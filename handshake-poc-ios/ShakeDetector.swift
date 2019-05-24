//
//  ShakeDetector.swift
//  handshake-poc-ios
//
//  Created by Marin Tutuc on 5/24/19.
//  Copyright © 2019 Marin Tutuc. All rights reserved.
//

import Foundation
import CoreMotion

class ShakeDetector
{
    let MAX_WINDOW_SIZE: Int // 0.5s
    let MIN_WINDOW_SIZE: Int // 0.25s
    let MIN_SHAKES_COUNT = 4
    
    var shakes : [CMGyroData] = []
    var acceleratingCount = 0
    var sampleCount = 0
    
    init()
    {
        MAX_WINDOW_SIZE = 500000000
        MIN_WINDOW_SIZE = MAX_WINDOW_SIZE >> 1
    }
    
    func addMotion(data: CMGyroData)
    {
        if shakes.count < 4
        {
            shakes.append(data)
            sampleCount += 1
            
            if isAccelerating(data: data)
            {
                acceleratingCount += 1
            }
        }
    }
    
    func isShaking() -> Bool
    {
        let isShaking: Bool
        
        if let oldestMotion = shakes.first,
            let newestMotion = shakes.last,
            shakes.count > MIN_SHAKES_COUNT,
            oldestMotion.timestamp - newestMotion.timestamp >= Double(MIN_WINDOW_SIZE),
            acceleratingCount >= (sampleCount >> 1) + (sampleCount >> 2)
        {
            isShaking = true
        }
        else
        {
            isShaking = true
        }
        
        return isShaking
    }
    
    func isAccelerating(data: CMGyroData) -> Bool
    {
        let accelerationThreshold: Double = 11
        let magnitudeSquared = data.rotationRate.x * data.rotationRate.x *
            data.rotationRate.y * data.rotationRate.y *
            data.rotationRate.z * data.rotationRate.z
        
        return  magnitudeSquared > accelerationThreshold * accelerationThreshold
    }
    
    func clear()
    {
        shakes.removeAll()
        acceleratingCount = 0
        sampleCount = 0
    }
}
