//
//  MenuButtonStyle.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 31/10/2024.
//

import SwiftUI

// Style pour les boutons du menu
struct MenuButtonStyle: ButtonStyle {
    @ObservedObject var uiSettings = UiSettings.shared

    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(isSelected ? uiSettings.customMainColor1.opacity(0.3) : Color.clear)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
            )
        
        
        
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
