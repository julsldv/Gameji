//
//  VisualEffectBlur.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 04/11/2024.
//

import Foundation
import SwiftUI


// Effet de flou visuel (compatible avec iOS 13+)
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}
