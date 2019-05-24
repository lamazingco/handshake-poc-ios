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
    let motionManager = CMMotionManager()
    let shaker = ShakeDetector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.gyroUpdateInterval = 0.5
        
        let str = "1234567"
        
        print("onSensorChanged: timestamp ns: \(str) ax=\(str) ay=\(str) az=\(str)")
        
        motionManager.startGyroUpdates(to: OperationQueue.current!)
        {
            (data, error) in
            
            if let data = data
            {
                self.shaker.addMotion(data: data)
                
                print("onSensorChanged: timestamp ns: \(data.timestamp) ax=\(data.rotationRate.x) ay=\(data.rotationRate.y) az=\(data.rotationRate.z)")
            }
        }
    }
}
