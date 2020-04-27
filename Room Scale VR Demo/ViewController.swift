//
//  ViewController.swift
//  Room Scale VR Demo
//
//  Created by Tom Alabaster on 27/04/2020.
//  Copyright © 2020 Tom Alabaster. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var leftEyeSceneView: ARSCNView!
    @IBOutlet var rightEyeSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        leftEyeSceneView.delegate = self
        
        // Show statistics such as fps and timing information
        leftEyeSceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        leftEyeSceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        leftEyeSceneView.session.run(configuration)
        
        leftEyeSceneView.scene.background.contents = UIColor.black
        
        rightEyeSceneView.scene = leftEyeSceneView.scene
        rightEyeSceneView.isPlaying = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        leftEyeSceneView.session.pause()
        rightEyeSceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let pov = leftEyeSceneView.pointOfView!.copy() as! SCNNode
        let orientation = pov.orientation
        let orientationQuaternion = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
        let eyePos = GLKVector3Make(1.0, 0.0, 0.0)
        let rotatedEyePos = GLKQuaternionRotateVector3(orientationQuaternion, eyePos)
        let rotatedEyePosSCNV = SCNVector3Make(rotatedEyePos.x, rotatedEyePos.y, rotatedEyePos.z)
        
        let mag: Float = 0.086
        pov.position.x += rotatedEyePosSCNV.x * mag
        pov.position.y += rotatedEyePosSCNV.y * mag
        pov.position.z += rotatedEyePosSCNV.z * mag
        
        rightEyeSceneView.pointOfView = pov
    }
}
