/*
See LICENSE folder for this sample’s licensing information.

Abstract:
SceneKit node giving the user hints about the status of ARKit world tracking.
*/

import Foundation
import ARKit

/**
An `SCNNode` which is used to provide uses with visual cues about the status of ARKit world tracking.
- Tag: FocusSquare
*/
@available(iOS 13.0, *)
class FocusSquare: SCNNode {
  enum State: Equatable {
      case initializing
      case detecting(raycastResult: ARRaycastResult, camera: ARCamera?)
  }

  // MARK: - Configuration Properties

  static let size: Float = 0.17
  static let thickness: Float = 0.018
  static let scaleForClosedSquare: Float = 0.97
  static let sideLengthForOpenSegments: CGFloat = 0.2
  static let animationDuration = 0.7
  static let primaryColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
  static let fillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

  // MARK: - Properties

  private var isOpen = false
  private var isAnimating = false
  private var isChangingOrientation = false
  private var isPointingDownwards = true
  private(set) var currentPlaneAnchor: ARPlaneAnchor?
  private var recentFocusSquarePositions: [SIMD3<Float>] = []
  private var anchorsOfVisitedPlanes: Set<ARAnchor> = []
  private var segments: [FocusSquare.Segment] = []
  private let positioningNode = SCNNode()
  private var counterToNextOrientationUpdate: Int = 0

  var lastPosition: SIMD3<Float>? {
    switch state {
    case .initializing: return nil
    case .detecting(let raycastResult, _):
      return raycastResult.worldTransform.translation
    }
  }

  var state: State = .initializing {
    didSet {
      guard state != oldValue else { return }

      switch state {
      case .initializing:
        displayAsBillboard()

      case let .detecting(raycastResult, camera):
        if let planeAnchor = raycastResult.anchor as? ARPlaneAnchor {
          displayAsClosed(for: raycastResult, planeAnchor: planeAnchor, camera: camera)
          currentPlaneAnchor = planeAnchor
        } else {
          displayAsOpen(for: raycastResult, camera: camera)
          currentPlaneAnchor = nil
        }
      }
    }
  }

  // MARK: - Initialization

  override init() {
    super.init()
    opacity = 0.0

    let s1 = Segment(name: "s1", corner: .topLeft, alignment: .horizontal)
    let s2 = Segment(name: "s2", corner: .topRight, alignment: .horizontal)
    let s3 = Segment(name: "s3", corner: .topLeft, alignment: .vertical)
    let s4 = Segment(name: "s4", corner: .topRight, alignment: .vertical)
    let s5 = Segment(name: "s5", corner: .bottomLeft, alignment: .vertical)
    let s6 = Segment(name: "s6", corner: .bottomRight, alignment: .vertical)
    let s7 = Segment(name: "s7", corner: .bottomLeft, alignment: .horizontal)
    let s8 = Segment(name: "s8", corner: .bottomRight, alignment: .horizontal)
    segments = [s1, s2, s3, s4, s5, s6, s7, s8]

    let sl: Float = 0.5  // segment length
    let c: Float = FocusSquare.thickness / 2 // correction to align lines perfectly
    s1.simdPosition += SIMD3<Float>(-(sl / 2 - c), -(sl - c), 0)
    s2.simdPosition += SIMD3<Float>(sl / 2 - c, -(sl - c), 0)
    s3.simdPosition += SIMD3<Float>(-sl, -sl / 2, 0)
    s4.simdPosition += SIMD3<Float>(sl, -sl / 2, 0)
    s5.simdPosition += SIMD3<Float>(-sl, sl / 2, 0)
    s6.simdPosition += SIMD3<Float>(sl, sl / 2, 0)
    s7.simdPosition += SIMD3<Float>(-(sl / 2 - c), sl - c, 0)
    s8.simdPosition += SIMD3<Float>(sl / 2 - c, sl - c, 0)

    positioningNode.eulerAngles.x = .pi / 2 // Horizontal
    positioningNode.simdScale = SIMD3<Float>(repeating: FocusSquare.size * FocusSquare.scaleForClosedSquare)
    for segment in segments {
      positioningNode.addChildNode(segment)
    }
    positioningNode.addChildNode(fillPlane)

    displayNodeHierarchyOnTop(true)

    addChildNode(positioningNode)

    displayAsBillboard()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("\(#function) has not been implemented")
  }

  // MARK: - Appearance

  func hide() {
    guard action(forKey: "hide") == nil else { return }

    displayNodeHierarchyOnTop(false)
    runAction(.fadeOut(duration: 0.5), forKey: "hide")
  }

  func unhide() {
    guard action(forKey: "unhide") == nil else { return }

    displayNodeHierarchyOnTop(true)
    runAction(.fadeIn(duration: 0.5), forKey: "unhide")
  }

  private func displayAsBillboard() {
    simdTransform = matrix_identity_float4x4
    eulerAngles.x = .pi / 2
    simdPosition = SIMD3<Float>(0, 0, -0.8)
    unhide()
    performOpenAnimation()
  }

  private func displayAsOpen(for raycastResult: ARRaycastResult, camera: ARCamera?) {
    performOpenAnimation()
    setPosition(with: raycastResult, camera)
  }

  private func displayAsClosed(for raycastResult: ARRaycastResult, planeAnchor: ARPlaneAnchor, camera: ARCamera?) {
    performCloseAnimation(flash: !anchorsOfVisitedPlanes.contains(planeAnchor))
    anchorsOfVisitedPlanes.insert(planeAnchor)
    setPosition(with: raycastResult, camera)
  }

  func setPosition(with raycastResult: ARRaycastResult, _ camera: ARCamera?) {
    let position = raycastResult.worldTransform.translation
    recentFocusSquarePositions.append(position)
    updateTransform(for: raycastResult, camera: camera)
  }

  // MARK: Helper Methods

  func updateOrientation(basedOn raycastResult: ARRaycastResult) {
    self.simdOrientation = raycastResult.worldTransform.orientation
  }

  private func updateTransform(for raycastResult: ARRaycastResult, camera: ARCamera?) {

    recentFocusSquarePositions = Array(recentFocusSquarePositions.suffix(10))

    // Move to average of recent positions to avoid jitter.
    let average = recentFocusSquarePositions.reduce(SIMD3<Float>(repeating: 0), { $0 + $1 }) / Float(recentFocusSquarePositions.count)
    self.simdPosition = average
    self.simdScale = SIMD3<Float>(repeating: scaleBasedOnDistance(camera: camera))

    // Correct y rotation when camera is close to horizontal
    // to avoid jitter due to gimbal lock.
    guard let camera = camera else { return }
    let tilt = abs(camera.eulerAngles.x)
    let threshold: Float = .pi / 2 * 0.75

    if tilt > threshold {
      if !isChangingOrientation {
        let yaw = atan2f(camera.transform.columns.0.x, camera.transform.columns.1.x)

        isChangingOrientation = true
        SCNTransaction.begin()
        SCNTransaction.completionBlock = {
          self.isChangingOrientation = false
          self.isPointingDownwards = true
        }
        SCNTransaction.animationDuration = isPointingDownwards ? 0.0 : 0.5
        self.simdOrientation = simd_quatf(angle: yaw, axis: SIMD3<Float>(0, 1, 0))
        SCNTransaction.commit()
      }
    } else {
      // Update orientation only twice per second to avoid jitter.
      if counterToNextOrientationUpdate == 30 || isPointingDownwards {
        counterToNextOrientationUpdate = 0
        isPointingDownwards = false

        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        updateOrientation(basedOn: raycastResult)
        SCNTransaction.commit()
      }

      counterToNextOrientationUpdate += 1
    }
  }

  /**
   Reduce visual size change with distance by scaling up when close and down when far away.

   These adjustments result in a scale of 1.0x for a distance of 0.7 m or less
   (estimated distance when looking at a table), and a scale of 1.2x
   for a distance 1.5 m distance (estimated distance when looking at the floor).
   */
  private func scaleBasedOnDistance(camera: ARCamera?) -> Float {
    guard let camera = camera else { return 1.0 }

    let distanceFromCamera = simd_length(simdWorldPosition - camera.transform.translation)
    if distanceFromCamera < 0.7 {
      return distanceFromCamera / 0.7
    } else {
      return 0.25 * distanceFromCamera + 0.825
    }
  }

  // MARK: Animations

  private func performOpenAnimation() {
    guard !isOpen, !isAnimating else { return }
    isOpen = true
    isAnimating = true

    // Open animation
    SCNTransaction.begin()
    SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    SCNTransaction.animationDuration = FocusSquare.animationDuration / 4
    positioningNode.opacity = 1.0
    for segment in segments {
      segment.open()
    }
    SCNTransaction.completionBlock = {
      self.positioningNode.runAction(pulseAction(), forKey: "pulse")
      self.isAnimating = false
    }
    SCNTransaction.commit()

    // Add a scale/bounce animation.
    SCNTransaction.begin()
    SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    SCNTransaction.animationDuration = FocusSquare.animationDuration / 4
    positioningNode.simdScale = SIMD3<Float>(repeating: FocusSquare.size)
    SCNTransaction.commit()
  }

  private func performCloseAnimation(flash: Bool = false) {
    guard isOpen, !isAnimating else { return }
    isOpen = false
    isAnimating = true

    positioningNode.removeAction(forKey: "pulse")
    positioningNode.opacity = 1.0

    // Close animation
    SCNTransaction.begin()
    SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    SCNTransaction.animationDuration = FocusSquare.animationDuration / 2
    positioningNode.opacity = 0.99
    SCNTransaction.completionBlock = {
      SCNTransaction.begin()
      SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
      SCNTransaction.animationDuration = FocusSquare.animationDuration / 4
      for segment in self.segments {
        segment.close()
      }
      SCNTransaction.completionBlock = { self.isAnimating = false }
      SCNTransaction.commit()
    }
    SCNTransaction.commit()

    // Scale/bounce animation
    positioningNode.addAnimation(scaleAnimation(for: "transform.scale.x"), forKey: "transform.scale.x")
    positioningNode.addAnimation(scaleAnimation(for: "transform.scale.y"), forKey: "transform.scale.y")
    positioningNode.addAnimation(scaleAnimation(for: "transform.scale.z"), forKey: "transform.scale.z")

    if flash {
      let waitAction = SCNAction.wait(duration: FocusSquare.animationDuration * 0.75)
      let fadeInAction = SCNAction.fadeOpacity(to: 0.25, duration: FocusSquare.animationDuration * 0.125)
      let fadeOutAction = SCNAction.fadeOpacity(to: 0.0, duration: FocusSquare.animationDuration * 0.125)
      fillPlane.runAction(SCNAction.sequence([waitAction, fadeInAction, fadeOutAction]))

      let flashSquareAction = flashAnimation(duration: FocusSquare.animationDuration * 0.25)
      for segment in segments {
        segment.runAction(.sequence([waitAction, flashSquareAction]))
      }
    }
  }

  // MARK: Convenience Methods

  private func scaleAnimation(for keyPath: String) -> CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: keyPath)

    let easeOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    let easeInOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    let linear = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

    let size = FocusSquare.size
    let ts = FocusSquare.size * FocusSquare.scaleForClosedSquare
    let values = [size, size * 1.15, size * 1.15, ts * 0.97, ts]
    let keyTimes: [NSNumber] = [0.00, 0.25, 0.50, 0.75, 1.00]
    let timingFunctions = [easeOut, linear, easeOut, easeInOut]

    scaleAnimation.values = values
    scaleAnimation.keyTimes = keyTimes
    scaleAnimation.timingFunctions = timingFunctions
    scaleAnimation.duration = FocusSquare.animationDuration

    return scaleAnimation
  }

  func displayNodeHierarchyOnTop(_ isOnTop: Bool) {
    func updateRenderOrder(for node: SCNNode) {
      node.renderingOrder = isOnTop ? 2 : 0

      for material in node.geometry?.materials ?? [] {
        material.readsFromDepthBuffer = !isOnTop
      }

      for child in node.childNodes {
        updateRenderOrder(for: child)
      }
    }

    updateRenderOrder(for: positioningNode)
  }

  private lazy var fillPlane: SCNNode = {
    let correctionFactor = FocusSquare.thickness / 2 
    let length = CGFloat(1.0 - FocusSquare.thickness * 2 + correctionFactor)

    let plane = SCNPlane(width: length, height: length)
    let node = SCNNode(geometry: plane)
    node.name = "fillPlane"
    node.opacity = 0.0

    let material = plane.firstMaterial!
    material.diffuse.contents = FocusSquare.fillColor
    material.isDoubleSided = true
    material.ambient.contents = UIColor.black
    material.lightingModel = .constant
    material.emission.contents = FocusSquare.fillColor

    return node
  }()
}

// MARK: - Animations and Actions

private func pulseAction() -> SCNAction {
  let pulseOutAction = SCNAction.fadeOpacity(to: 0.4, duration: 0.5)
  let pulseInAction = SCNAction.fadeOpacity(to: 1.0, duration: 0.5)
  pulseOutAction.timingMode = .easeInEaseOut
  pulseInAction.timingMode = .easeInEaseOut

  return SCNAction.repeatForever(SCNAction.sequence([pulseOutAction, pulseInAction]))
}

private func flashAnimation(duration: TimeInterval) -> SCNAction {
  let action = SCNAction.customAction(duration: duration) { (node, elapsedTime) -> Void in
    // animate color from HSB 48/100/100 to 48/30/100 and back
    let elapsedTimePercentage = elapsedTime / CGFloat(duration)
    let saturation = 2.8 * (elapsedTimePercentage - 0.5) * (elapsedTimePercentage - 0.5) + 0.3
    if let material = node.geometry?.firstMaterial {
      material.diffuse.contents = UIColor(hue: 0.1333, saturation: saturation, brightness: 1.0, alpha: 1.0)
    }
  }
  return action
}

