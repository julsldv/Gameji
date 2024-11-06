//
//  BetTapBarView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 09/09/2024.
//

import SwiftUI

struct BetTapBarView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Binding var selectedTab: Int // Index de l'onglet sélectionné
    @Namespace private var animationNamespace // Namespace pour l'animation de la barre
    @State private var buttonFrames: [CGRect] = [.zero, .zero] // Positions des boutons

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack(spacing: 0) {
                TapBarButtonView(text: "En cours", index: 0, selectedTab: $selectedTab, buttonFrames: $buttonFrames, animationNamespace: animationNamespace)
                TapBarButtonView(text: "Terminés", index: 1, selectedTab: $selectedTab, buttonFrames: $buttonFrames, animationNamespace: animationNamespace)
            }
            .frame(height: 40)

            // Barre blanche animée avec effet de rebond
            if buttonFrames[selectedTab] != .zero {
                Color.white
                    .frame(width: buttonFrames[selectedTab].width * 0.6, height: 3) // Ajuste la largeur ici si nécessaire
                    .offset(x: buttonFrames[selectedTab].minX + buttonFrames[selectedTab].width * 0.2) // Centre la barre sous le texte
                    .animation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.2), value: selectedTab) // Effet de rebond
                    .matchedGeometryEffect(id: "underline", in: animationNamespace)
            }

        }
    }
}

