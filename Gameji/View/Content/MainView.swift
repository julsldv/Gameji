//
//  MainView.swift
//  Gameji
//
//  Created par Julien PORTOLAN on 06/09/2024.
//


import SwiftUI

struct MainView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()
    
    @State private var showBetPlacementView = false
    @State private var selectedMarket: Market?
    @State private var betAmount: Int = 0
    @State private var showProfilView = false
    @State private var showBetListView = false
    @State private var chosenOption: String = ""
    @State private var showBetRecap = false
    @State private var showSportsList = false
    @State private var selectedSport = "Sports"
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TopView(showProfilView: $showProfilView, showBetListView: $showBetListView)
                
                ScrollView (showsIndicators: false) {
                    SpacerRectangle(width: 1, height: 1)
                    
                    // MenuView pour sélectionner le sport
                    MenuView(selectedSport: $selectedSport, showSportsList: $showSportsList)
                    
                    SpacerRectangle(width: 1, height: 1)
                    
                    if selectedSport != "Sports" {
                        // Filtré pour un sport spécifique
                        MatchCardListView(
                            authViewModel: authViewModel,
                            chosenOption: $chosenOption,
                            betAmount: $betAmount,
                            showBetRecap: $showBetRecap,
                            showBetPlacementView: $showBetPlacementView,
                            selectedMarket: $selectedMarket,
                            selectedSport: selectedSport
                        )
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    else {
                        // Vue par défaut avec toutes les sections
                        VStack(spacing: 15) {
                            MarketListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                selectedSport: $selectedSport
                            )
                            
                            SmallCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                labelDuTop: "Actuellement les meilleures cotes",
                                selectedSport: selectedSport
                            )
                            
                            MediumCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                labelDuTop: "Top 10 Mycombis aujourd'hui en France",
                                selectedSport: selectedSport
                            )
                            
                            MatchCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                selectedSport: "Football"
                            )
                            
                            SmallCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                labelDuTop: "Top buteurs",
                                selectedSport: "Football"
                            )
                            
                            MatchCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                selectedSport: "Tennis"
                            )
                            
                            SmallCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                labelDuTop: "Inspiré de vos précédentes victoires",
                                selectedSport: selectedSport
                            )
                            
                            MatchCardListView(
                                authViewModel: authViewModel,
                                chosenOption: $chosenOption,
                                betAmount: $betAmount,
                                showBetRecap: $showBetRecap,
                                showBetPlacementView: $showBetPlacementView,
                                selectedMarket: $selectedMarket,
                                selectedSport: "Basket"
                            )
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("bg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            
            if authViewModel.showDailyBonusModal {
                VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    DailyBonusView(showDailyBonusModal: $authViewModel.showDailyBonusModal) {
                        authViewModel.creditDailyBonus()
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedCorners(radius: 50, corners: [.topLeft, .topRight]))
                    .shadow(radius: 10)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: authViewModel.showDailyBonusModal)
                .onAppear {
                    HapticManager.triggerLightImpact()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        HapticManager.triggerHeavyImpact()
                    }
                }
            }
            
            if showBetRecap {
                VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    BetRecapView(showBetRecap: $showBetRecap)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedCorners(radius: 50, corners: [.topLeft, .topRight]))
                        .shadow(radius: 10)
                }
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showBetRecap)
                .onAppear {
                    HapticManager.triggerLightImpact()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        HapticManager.triggerHeavyImpact()
                    }
                }
            }
            
            if showSportsList {
                ZStack {
                    VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        SportsListView(selectedSport: $selectedSport, showSportsList: $showSportsList)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showSportsList)
                    .onAppear {
                        HapticManager.triggerLightImpact()
                    }
                }
            }
            
            if showBetPlacementView {
                ZStack {
                    VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        BetPlacementView(
                            authViewModel: authViewModel, showBetPlacementView: $showBetPlacementView,
                            betAmount: $betAmount,
                            chosenOption: $chosenOption,
                            selectedMarket: $selectedMarket,
                            showBetRecap: $showBetRecap
                        )
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showBetPlacementView)
                }
            }
            
            if showProfilView {
                ZStack {
                    VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        ProfilView(showProfilView: $showProfilView)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showProfilView)
                    .onAppear {
                        HapticManager.triggerLightImpact()
                    }
                }
            }
              
            if showBetListView {
                ZStack {
                    VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        BetListView(showBetListView: $showBetListView)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showBetListView)
                    .onAppear {
                        HapticManager.triggerLightImpact()
                    }
                }
            }
               
        }
    }
}

#Preview {
    MainView()
}



