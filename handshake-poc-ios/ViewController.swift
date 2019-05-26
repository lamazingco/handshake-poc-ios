//
//  ViewController.swift
//  handshake-poc-ios
//
//  Created by Marin Tutuc on 5/24/19.
//  Copyright © 2019 Marin Tutuc. All rights reserved.
//


import UIKit
import CoreMotion

class ViewController: UIViewController
{
    let lastAx = Double()
    let lastAy = Double()
    let lastAz = Double()
    let motionManager = CMMotionManager()
    let shaker = ShakeDetector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.gyroUpdateInterval = 0.01
        
        motionManager.startGyroUpdates(to: OperationQueue.current!)
        {
            (data, error) in
            
            if let data = data
            {
                self.shaker.addMotion(data: data)
                let diffAx = data.rotationRate.x - self.lastAx
                let diffAy = data.rotationRate.y - self.lastAy
                let diffAz = data.rotationRate.z - self.lastAz
                
                if diffAx > 1 || diffAy > 1 || diffAz > 1 {
                    print("onSensorChanged: timestamp ns: \(data.timestamp) ax=\(data.rotationRate.x) ay=\(data.rotationRate.y) az=\(data.rotationRate.z)")
                }
                
            }
        }
    }
}
