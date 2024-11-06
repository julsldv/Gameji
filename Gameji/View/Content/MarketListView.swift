//
//  MarketListView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//


import SwiftUI

struct MarketListView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()
    
    @Binding var chosenOption: String
    @Binding var betAmount: Int
    @Binding var showBetRecap: Bool
    @Binding var showBetPlacementView: Bool
    @Binding var selectedMarket: Market?
    @Binding var selectedSport: String
    
    @State private var selectedCardIndex = 0

    // Filtrer les marchés ouverts, spéciaux, et correspondant au sport sélectionné
    private var openSpecialMarkets: [Market] {
        authViewModel.markets.filter {
            $0.status == "ouvert" && $0.special && (selectedSport == "Sports" || $0.sport == selectedSport)
        }
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedCardIndex) {
                ForEach(Array(openSpecialMarkets.enumerated()), id: \.0) { index, market in
                    MarketView(
                        market: market,
                        chosenOption: $chosenOption,
                        showBetPlacement: openBetPlacementView,
                        uiSettings: uiSettings
                    )
                    .tag(index)
                    .shadow(radius: 5)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 390)
            
            // Indicateur de pagination personnalisé
            HStack(spacing: 8) {
                ForEach(0..<openSpecialMarkets.count, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(index == selectedCardIndex ? uiSettings.customRedColor3 : uiSettings.customRedColor3.opacity(0.3))
                        .frame(width: index == selectedCardIndex ? 30 : 8, height: 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.white, lineWidth: index == selectedCardIndex ? 1 : 0)
                        )
                        .animation(.easeInOut(duration: 0.5), value: selectedCardIndex)
                }
            }
            .padding(.top, 0)
        }
    }
    
    private func openBetPlacementView(market: Market, option: String) {
        self.selectedMarket = market
        self.chosenOption = option
        self.showBetPlacementView = true
    }
}

struct MarketListView_Previews: PreviewProvider {
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
            "competition": "Ligue 1",
            "special": true
        ]
    )
    @State static var selectedSport = "Football" // Sport sélectionné pour l'aperçu

    static var previews: some View {
        MarketListView(
            uiSettings: UiSettings.shared,
            authViewModel: MockAuthViewModel(),
            chosenOption: $chosenOption,
            betAmount: $betAmount,
            showBetRecap: $showBetRecap,
            showBetPlacementView: $showBetPlacementView,
            selectedMarket: $selectedMarket,
            selectedSport: $selectedSport
        )
        .previewLayout(.sizeThatFits)
    }
}
