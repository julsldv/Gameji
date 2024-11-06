//
//  SmallCardView_old.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 30/10/2024.
//

import SwiftUI

struct SmallCardView_old: View {
    var market: Market
    @Binding var chosenOption: String
    var showBetPlacement: (Market, String) -> Void
    @ObservedObject var uiSettings: UiSettings

    // État pour gérer l'effet d'enfoncement
    @State private var selectedOption: String? = nil
    @State private var isPressed = false // État d'enfoncement de la carte
    
    // Liste des images disponibles
    let images = ["NBA", "foot2", "foot3", "foot4", "foot5", "foot6", "foot7", "foot8", "foot9", "foot10", "foot11", "NADAL"]
    @State private var randomImage: String
    
    init(market: Market, chosenOption: Binding<String>, showBetPlacement: @escaping (Market, String) -> Void, uiSettings: UiSettings) {
        self.market = market
        self._chosenOption = chosenOption
        self.showBetPlacement = showBetPlacement
        self.uiSettings = uiSettings
        _randomImage = State(initialValue: images.randomElement() ?? "foot2")
    }

    var body: some View {
        ZStack {
            // La carte entière devient cliquable et inclut l'effet d'enfoncement
            Button(action: {
                if let firstOption = market.options.first {
                    print("Utilisateur a tapé sur l'option : \(firstOption)")
                    
                    selectedOption = firstOption
                    print("selectedOption mis à jour avec : \(selectedOption ?? "aucune option")")
                    
                    chosenOption = firstOption
                    print("chosenOption mis à jour avec : \(chosenOption)")
                    
                    showBetPlacement(market, firstOption)
                    print("showBetPlacement appelé pour le marché : \(market.label) avec l'option : \(firstOption)")
                } else {
                    print("Aucune option disponible pour le marché : \(market.label)")
                }
            }) {
                ZStack(alignment: .bottom) {
                    // Image de fond couvrant toute la carte
                    Image(randomImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 200)
                        .clipped()
                        .cornerRadius(12)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )
                    
                    // Contenu superposé (texte et bouton)
                    VStack(spacing: 8) {
                        Text(market.label)
                            .font(.custom(uiSettings.customFontName, size: 14))
                            .bold()
                            .foregroundColor(uiSettings.customFontColor2)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(5)
                        
                        if let firstOption = market.options.first {
                            Text(firstOption)
                                .font(.system(size: 12, design: .rounded))
                                .foregroundColor(uiSettings.customFontColor1)
                                .bold()
                                .frame(width: 100, height: 35)
                                .background(uiSettings.customOddkColor1)
                                .cornerRadius(5)
                        } else {
                            Text("Aucune option disponible")
                                .font(.system(size: 12, design: .rounded))
                                .foregroundColor(.gray)
                                .italic()
                                .frame(width: 100, height: 35)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                    .padding(.bottom, 10)
                }
                .frame(width: 140, height: 200)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [uiSettings.customBackColor3, uiSettings.customBackColor2, uiSettings.customRedColor3]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 5
                        )
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            }
            .scaleEffect(isPressed ? 0.90 : 1.0) // Effet d'enfoncement
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onChanged { _ in
                        isPressed = true // Active l'effet d'enfoncement
                    }
                    .onEnded { _ in
                        isPressed = false // Relâche l'effet
                    }
            )
        }
        .buttonStyle(PlainButtonStyle()) // Supprime l'effet visuel par défaut du bouton
        .frame(width: 140, height: 200) // Assure que le bouton occupe toute la zone
        .cornerRadius(12)
    }
}

// Preview avec des données de test pour Market
struct SmallCardView_old_Previews: PreviewProvider {
    static var previews: some View {
        // Données de test pour initialiser le Market
        let testData: [String: Any] = [
            "label": "Match de la Semaine",
            "options": ["Équipe A"],
            "correctAnswer": "Équipe A",
            "status": "ouvert",
            "sport": "football",
            "competition": "Ligue 1"
        ]
        
        // Création d'un Market avec les données de test
        let testMarket = Market(id: "1", data: testData)
        
        SmallCardView_old(
            market: testMarket,
            chosenOption: .constant("Équipe A"),
            showBetPlacement: { market, option in
                print("Option choisie : \(option) pour le marché \(market.label)")
            },
            uiSettings: UiSettings()
        )
        .previewLayout(.sizeThatFits)
    }
}

