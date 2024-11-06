//
//  MediumCardListView.swift
//  Gameji
//
//  Created par Julien PORTOLAN on 01/11/2024.
//

import SwiftUI

struct MediumCardListView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel: AuthViewModel
    
    @Binding var chosenOption: String
    @Binding var betAmount: Int
    @Binding var showBetRecap: Bool
    @Binding var showBetPlacementView: Bool
    @Binding var selectedMarket: Market?
    
    var labelDuTop: String
    var selectedSport: String

    var body: some View {
        VStack(spacing: 3) {
            // Affichage du titre de la section
            HStack {
                Text(labelDuTop)
                    .font(.custom(uiSettings.customFontName, size: 18))
                    .bold()
                    .foregroundColor(uiSettings.customFontColor2)
                Spacer()
            }
            .padding(.horizontal, 5)

            // ScrollView horizontale pour les cartes
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 70) { // Augmentez l'espacement ici
                    ForEach(Array(authViewModel.markets
                                    .filter { $0.status == "ouvert" && (selectedSport == "Sports" || $0.sport == selectedSport) }
                                    .enumerated()), id: \.element.id) { index, market in
                        
                        ZStack(alignment: .leading) {
                            // Numéro de position avec style
                            
                            Text("\(index + 1)")
                                .font(.custom(uiSettings.customFontName, size: 200))
                                .bold()
                                .foregroundColor(.white.opacity(0.3))
                                .offset(x: -70, y: 70)

                            // Affichage de la carte
                            MediumCardView(
                                market: market,
                                chosenOption: $chosenOption,
                                showBetPlacement: openBetPlacementView,
                                uiSettings: uiSettings
                            )
                            .padding(.leading, 20) // Ajuste l'alignement avec le numéro
                        }
                        .offset(x: 30)
                    }
                    .padding(.vertical, 5)
                }
                .padding(.horizontal, 30) // Espacement externe entre chaque couple de carte
            }
        }
        .padding(5)
    }

    private func openBetPlacementView(market: Market, option: String) {
        selectedMarket = market
        chosenOption = option
        showBetPlacementView = true
    }
}

struct MediumCardListView_Previews: PreviewProvider {
    @State static var chosenOption = "Option1"
    @State static var betAmount = 50
    @State static var showBetRecap = false
    @State static var showBetPlacementView = false
    @State static var selectedMarket: Market? = Market(
        id: "1",
        data: [
            "label": "Marché de Test",
            "options": ["Option A", "Option B"],
            "correctAnswer": "Option A",
            "status": "ouvert",
            "sport": "football",
            "competition": "Ligue 1"
        ]
    )
    @State static var selectedSport = "Football"

    static var previews: some View {
        // Instanciation de `MediumCardListView` avec des données de test
        MediumCardListView(
            uiSettings: UiSettings.shared,
            authViewModel: MockAuthViewModel(),
            chosenOption: $chosenOption,
            betAmount: $betAmount,
            showBetRecap: $showBetRecap,
            showBetPlacementView: $showBetPlacementView,
            selectedMarket: $selectedMarket,
            labelDuTop: "Les meilleures cotes",
            selectedSport: selectedSport
        )
        .previewLayout(.sizeThatFits)
        .background(.blue)
    }
}


