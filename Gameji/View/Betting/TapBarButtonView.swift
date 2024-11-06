//
//  TapBarButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 09/09/2024.
//

import SwiftUI

struct TapBarButtonView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    let text: String
    let index: Int
    @Binding var selectedTab: Int
    @Binding var buttonFrames: [CGRect] // Référence pour stocker la position de chaque bouton
    var animationNamespace: Namespace.ID // Namespace pour l'animation de la barre

    var isSelected: Bool {
        index == selectedTab
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedTab = index
            }
        }) {
            VStack {
                Text(text)
                    .font(.system(size: 17, design: .rounded))
                    .foregroundColor(isSelected ? Color.white :  Color.white.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 5)

                // Utiliser GeometryReader pour obtenir la position de chaque bouton
                GeometryReader { geometry in
                    Color.clear // Élément invisible pour capturer la position
                        .onAppear {
                            // Stocker la position et la taille du bouton dans `buttonFrames`
                            DispatchQueue.main.async {
                                buttonFrames[index] = geometry.frame(in: .global)
                            }
                        }
                }
                .frame(height: 0) // Utiliser une hauteur nulle pour cacher le `GeometryReader`
            }
            .padding(3)
            .frame(height: 50)
        }
        .background(Color.clear)
    }
}

