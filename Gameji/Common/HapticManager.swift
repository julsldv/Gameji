//
//  HapticManager.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import UIKit

struct HapticManager {
    static func triggerLightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
    
    static func triggerHeavyImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    
}
