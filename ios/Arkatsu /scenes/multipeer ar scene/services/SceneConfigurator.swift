//
//  SceneConfigurator.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 05.03.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

struct SceneConfigurator {

    static func loadAnimation(animationKey: String, identifier: String) -> CAAnimation? {

        let sceneURL = Bundle.main.url(forResource: animationKey, withExtension: "dae", subdirectory: "Models.scnassets")!

        let source = SCNSceneSource(url: sceneURL, options: nil)

        guard let animationObject = source?.entryWithIdentifier(identifier, withClass: CAAnimation.self) else {
            return nil
        }

        animationObject.repeatCount = 1
        animationObject.isRemovedOnCompletion = false
        return animationObject
    }

}

