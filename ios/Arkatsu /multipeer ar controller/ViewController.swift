/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 Main view controller for the AR experience.
 */

import UIKit
import SceneKit
import ARKit
import MultipeerConnectivity

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
  // MARK: - IBOutlets

  @IBOutlet weak var sessionInfoView: UIView!
  @IBOutlet weak var sessionInfoLabel: UILabel!
  @IBOutlet weak var sceneView: ARSCNView!
  @IBOutlet weak var sendMapButton: UIButton!
  @IBOutlet weak var mappingStatusLabel: UILabel!

  var petModel: SCNNode?
  var tapCounter: Int = 0

  // MARK: - View Life Cycle

  var multipeerSession: MultipeerSession!

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    tabBarItem = UITabBarItem(
      title: nil,
      image: UIImage(named: "diamond"),
      selectedImage: UIImage(named: "diamond")?.withRenderingMode(.alwaysOriginal)
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    multipeerSession = MultipeerSession(receivedDataHandler: receivedData)

    // Adding swipe gesture
    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeUp.direction = .up
    self.view.addGestureRecognizer(swipeUp)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    guard ARWorldTrackingConfiguration.isSupported else {
      fatalError("""
              ARKit is not available on this device. For apps that require ARKit
              for core functionality, use the `arkit` key in the key in the
              `UIRequiredDeviceCapabilities` section of the Info.plist to prevent
              the app from installing. (If the app can't be installed, this error
              can't be triggered in a production scenario.)
              In apps where AR is an additive feature, use `isSupported` to
              determine whether to show UI for launching AR experiences.
          """) // For details, see https://developer.apple.com/documentation/arkit
    }

    // Start the view's AR session.
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = .horizontal
    sceneView.session.run(configuration)

    // Set a delegate to track the number of plane anchors for providing UI feedback.
    sceneView.session.delegate = self

    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    // Prevent the screen from being dimmed after a while as users will likely
    // have long periods of interaction without touching the screen or buttons.
    UIApplication.shared.isIdleTimerDisabled = true

  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    // Pause the view's AR session.
    sceneView.session.pause()
  }

  // MARK: - ARSCNViewDelegate

  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    if let name = anchor.name, name.hasPrefix("panda") {
      petModel = loadRedPandaModel()
      node.addChildNode(petModel!)
    }
  }

  // MARK: - ARSessionDelegate

  func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
    updateSessionInfoLabel(for: session.currentFrame!, trackingState: camera.trackingState)
  }

  /// - Tag: CheckMappingStatus
  func session(_ session: ARSession, didUpdate frame: ARFrame) {
    switch frame.worldMappingStatus {
    case .notAvailable, .limited:
      sendMapButton.isEnabled = false
    case .extending:
      sendMapButton.isEnabled = !multipeerSession.connectedPeers.isEmpty
    case .mapped:
      sendMapButton.isEnabled = !multipeerSession.connectedPeers.isEmpty
    @unknown default:
      fatalError()
    }
    mappingStatusLabel.text = frame.worldMappingStatus.description
    updateSessionInfoLabel(for: frame, trackingState: frame.camera.trackingState)
  }

  // MARK: - ARSessionObserver

  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay.
    sessionInfoLabel.text = "Session was interrupted"
  }

  func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required.
    sessionInfoLabel.text = "Session interruption ended"
  }

  func session(_ session: ARSession, didFailWithError error: Error) {
    sessionInfoLabel.text = "Session failed: \(error.localizedDescription)"
    guard error is ARError else { return }

    let errorWithInfo = error as NSError
    let messages = [
      errorWithInfo.localizedDescription,
      errorWithInfo.localizedFailureReason,
      errorWithInfo.localizedRecoverySuggestion
    ]

    // Remove optional error messages.
    let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")

    DispatchQueue.main.async {
      // Present an alert informing about the error that has occurred.
      let alertController = UIAlertController(title: "The AR session failed.", message: errorMessage, preferredStyle: .alert)
      let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
        alertController.dismiss(animated: true, completion: nil)
        self.resetTracking(nil)
      }
      alertController.addAction(restartAction)
      self.present(alertController, animated: true, completion: nil)
    }
  }

  // MARK: - Multiuser shared session

  /// - Tag: PlaceCharacter
  @IBAction func handleSceneTap(_ sender: UITapGestureRecognizer) {

    // Hit test to find a place for a virtual object.
    guard let hitTestResult = sceneView
      .hitTest(sender.location(in: sceneView), types: [.existingPlaneUsingGeometry, .estimatedHorizontalPlane])
      .first
      else { return }

    guard tapCounter == 0 else {
      return
    }

    // Place an anchor for a virtual character. The model appears in renderer(_:didAdd:for:).
    let anchor = ARAnchor(name: "panda", transform: hitTestResult.worldTransform)
    sceneView.session.add(anchor: anchor)

    // Send the anchor info to peers, so they can place the same content.
    guard let data = try? NSKeyedArchiver.archivedData(withRootObject: anchor, requiringSecureCoding: true)
      else { fatalError("can't encode anchor") }
    self.multipeerSession.sendToAllPeers(data)

    tapCounter += 1
  }

  /// - Tag: GetWorldMap

  @IBAction func shareSession(_ button: UIButton) {
    sceneView.session.getCurrentWorldMap { worldMap, error in
      guard let map = worldMap
        else { print("Error: \(error!.localizedDescription)"); return }
      // TODO
      //      let worldData = WorldData(map: map, petName: AppDelegate.petName)
      guard let data = try? NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
        else { fatalError("can't encode map") }
      self.multipeerSession.sendToAllPeers(data)
    }
  }

  @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    guard gesture.direction == .up, let pet = petModel, let animation = SceneConfigurator.loadAnimation(animationKey: "panda_jump", identifier: "panda_jump-1") else {
      return
    }

    pet.addAnimation(animation, forKey: "panda_jump")


    let oldPosition = pet.position
    let newPosition = SCNVector3(
        oldPosition.x,
        oldPosition.y + Specs.heightOfJump,
        oldPosition.z
    )

    let upAction = SCNAction.move(to: newPosition, duration: TimeInterval(Specs.characterJumpDuration))
    let downAction = SCNAction.move(to: oldPosition, duration: TimeInterval(Specs.characterJumpDuration))

    pet.runAction(upAction) { [weak self] in
      pet.runAction(downAction)
    }
  }


  var mapProvider: MCPeerID?

  /// - Tag: ReceiveData
  func receivedData(_ data: Data, from peer: MCPeerID) {

    do {
      if let worldData = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) {
        // Run the session with the received world map.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.initialWorldMap = worldData
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        // Remember who provided the map for showing UI feedback.
        mapProvider = peer
      }
      else if let anchor = try NSKeyedUnarchiver.unarchivedObject(ofClass: ARAnchor.self, from: data) {
        // Add anchor to the session, ARSCNView delegate adds visible content.
        sceneView.session.add(anchor: anchor)
      }
      else {
        print("unknown data recieved from \(peer)")
      }
    } catch {
      print("can't decode data recieved from \(peer)")
    }
  }

  // MARK: - AR session management

  private func updateSessionInfoLabel(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
    // Update the UI to provide feedback on the state of the AR experience.
    let message: String

    switch trackingState {
    case .normal where frame.anchors.isEmpty && multipeerSession.connectedPeers.isEmpty:
      // No planes detected; provide instructions for this app's AR interactions.
      message = "Move around to map the environment, or wait to join a shared session."

    case .normal where !multipeerSession.connectedPeers.isEmpty && mapProvider == nil:
      let peerNames = multipeerSession.connectedPeers.map({ $0.displayName }).joined(separator: ", ")
      message = "Connected with \(peerNames)."

    case .notAvailable:
      message = "Tracking unavailable."

      case .limited(.excessiveMotion):
          message = "Tracking limited - Move the device more slowly."

      case .limited(.insufficientFeatures):
          message = "Tracking limited - Point the device at an area with visible surface detail, or improve lighting conditions."

      case .limited(.initializing) where mapProvider != nil,
           .limited(.relocalizing) where mapProvider != nil:
          message = "Received map from \(mapProvider!.displayName)."

      case .limited(.relocalizing):
          message = "Resuming session — move to where you were when the session was interrupted."

      case .limited(.initializing):
          message = "Initializing AR session."

      default:
          // No feedback needed when tracking is normal and planes are visible.
          // (Nor when in unreachable limited-tracking states.)
          message = ""

      }

      sessionInfoLabel.text = message
      sessionInfoView.isHidden = message.isEmpty
  }

  @IBAction func resetTracking(_ sender: UIButton?) {
      let configuration = ARWorldTrackingConfiguration()
      configuration.planeDetection = .horizontal
      sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
      tapCounter = 0
  }

  // MARK: - AR session management
  private func loadRedPandaModel() -> SCNNode {
      let sceneURL = Bundle.main.url(forResource: "redPanda", withExtension: "scn", subdirectory: "Models.scnassets")!
      let referenceNode = SCNReferenceNode(url: sceneURL)!
      referenceNode.load()

      return referenceNode
  }

  private func loadBluePandaModel() -> SCNNode {
      let sceneURL = Bundle.main.url(forResource: "bluePanda", withExtension: "scn", subdirectory: "Models.scnassets")!
      let referenceNode = SCNReferenceNode(url: sceneURL)!
      referenceNode.load()

      return referenceNode
  }
}

private enum Specs {
  static let characterJumpDuration = 1
  static let heightOfJump = Float(20)
}
