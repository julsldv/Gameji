//
//  SmallCardListView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 30/10/2024.
//

import SwiftUI

struct SmallCardListView: View {
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
            HStack {
                Text(labelDuTop)
                    .font(.custom(uiSettings.customFontName, size: 18))
                    .bold()
                    .foregroundColor(uiSettings.customFontColor2)
                
                Spacer()
            }
            .padding(.horizontal, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(authViewModel.markets
                                .filter { $0.status == "ouvert" && (selectedSport == "Sports" || $0.sport == selectedSport) }
                                .shuffled()
                                .prefix(10)
                    ) { market in
                        SmallCardView(
                            market: market,
                            chosenOption: $chosenOption,
                            showBetPlacement: openBetPlacementView,
                            uiSettings: uiSettings
                        )
                    }
                }
                .padding(5)
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

