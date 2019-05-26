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
        
        motionManager.accelerometerUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data{
                let date = (Date().timeIntervalSince1970*10).rounded()
                print("onSensorChanged: timestamp : \(date) ax=\(data.acceleration.x) ay=\(data.acceleration.y) az=\(data.acceleration.z)")
                }
            }
        
    }
}
