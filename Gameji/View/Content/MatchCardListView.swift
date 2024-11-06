//
//  MatchCardListView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 03/11/2024.
//

import SwiftUI

struct MatchCardListView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel: AuthViewModel
    
    @Binding var chosenOption: String
    @Binding var betAmount: Int
    @Binding var showBetRecap: Bool
    @Binding var showBetPlacementView: Bool
    @Binding var selectedMarket: Market?
    
    var selectedSport: String

    var body: some View {
        VStack(spacing: 15) {
            // Limite le nombre de cartes affichées en utilisant le paramètre `Sport`
            ForEach(Array(authViewModel.markets
                        .filter { $0.status == "ouvert" && (selectedSport == "Sports" || $0.sport == selectedSport) }
                        .enumerated()), id: \.element.id) { index, market in
                
                // Affichage de la carte
                MatchCardView(
                    market: market,
                    chosenOption: $chosenOption,
                    showBetPlacement: openBetPlacementView,
                    uiSettings: uiSettings
                )
            }
        }
    }

    private func openBetPlacementView(market: Market, option: String) {
        selectedMarket = market
        chosenOption = option
        showBetPlacementView = true
    }
}

struct MatchCardListView_Previews: PreviewProvider {
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
        // Instanciation de `MatchCardListView` avec des données de test et limite de cartes
        MatchCardListView(
            uiSettings: UiSettings.shared,
            authViewModel: MockAuthViewModel(),
            chosenOption: $chosenOption,
            betAmount: $betAmount,
            showBetRecap: $showBetRecap,
            showBetPlacementView: $showBetPlacementView,
            selectedMarket: $selectedMarket,
            selectedSport: selectedSport
        )
        .previewLayout(.sizeThatFits)
        .background(.blue)
    }
}

