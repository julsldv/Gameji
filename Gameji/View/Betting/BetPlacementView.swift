//
//  BetPlacementView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//


import SwiftUI

struct BetPlacementView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared
    @ObservedObject var authViewModel: AuthViewModel

    
    @Binding var showBetPlacementView: Bool
    @Binding var betAmount: Int
    @Binding var chosenOption: String
    @Binding var selectedMarket: Market?
    @Binding var showBetRecap: Bool
    
    @State private var showModalError = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var betAmountString: String = ""
    @FocusState private var isInputActive: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        CloseButtonView {
                            resetState()
                            isInputActive = false
                            showBetPlacementView = false
                            globalSettings.showTabBar = true
                        }
                        
                        Spacer()

                        // Conteneur pour les balances, centré
                        HStack(spacing: 10) {
                            FreebetBalanceView()
                            BalanceView()
                        }

                        Spacer()

                    }
                    .padding(10)

                }
                .frame(maxWidth: .infinity)

                ScrollView {
                    VStack {
                        VStack {
                            HStack {
                                    if let market = selectedMarket {
                                        HStack {
                                            Text(sportIcon(for: market.sport))
                                                .font(.custom(uiSettings.customFontName, size: 16))
                                            Text(market.label)
                                                .font(.custom(uiSettings.customFontName, size: 16))
                                                .foregroundColor(uiSettings.customFontColor2)
                                            Spacer()
                                        }
                                    }
                                
                                
                                Spacer()
                                
                                CloseBetButtonView {
                                    isInputActive = false
                                    showBetPlacementView = false
                                    globalSettings.showTabBar = true
                                    

                                }
                            }
                            HStack {
                                Text("Résultat :")
                                   
                                    .font(.custom(uiSettings.customFontName, size: 16))
                                    .foregroundColor(uiSettings.customFontColor2)
                                    
                                Text(chosenOption)
                                   
                                    .font(.custom(uiSettings.customFontName, size: 20))
                                    .foregroundColor(uiSettings.customFontColor2)
                                    .bold()
                                Spacer()
                            }
                           
                            
                            Divider().padding(5)
                            
                            TextField("Mise", text: $betAmountString)
                                .padding(10)
                                .background(uiSettings.customFontColor2.opacity(0.1))
                                .font(.custom(uiSettings.customFontName, size: 20))
                                .keyboardType(.numberPad)
                                .foregroundColor(uiSettings.customFontColor2)
                                .bold()
                                .multilineTextAlignment(.center)
                                .focused($isInputActive)
                                .onTapGesture { betAmountString = "" }
                                .onChange(of: betAmountString) { newValue in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        betAmount = Int(betAmountString) ?? 0
                                    }
                                }
                                .cornerRadius(10)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .frame(width: UIScreen.main.bounds.width * 0.90)
                    }
                    .background(uiSettings.customBackColor1)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(uiSettings.customFontColor2.opacity(0.1), lineWidth: 2)
                    )
                    .padding(20)
                   
                }

                Spacer()

                VStack {
                    HStack {
                        SpacerRectangle(width: 1, height: 1)
                        Text("Gains possibles")
                            .font(.custom(uiSettings.customFontName, size: 18))
                            .foregroundColor(.white.opacity(0.8))
                            .bold()
                        Spacer()
                        Text("\(betAmount)")
                            .font(.custom(uiSettings.customFontName, size: 22))
                            .foregroundColor(.white.opacity(0.8))
                            .bold()
                        SpacerRectangle(width: 1, height: 1)
                    }
                 
                    HStack {
                        ButtonLargeView(textButton: "Valider mon pari") {
                            placeBet()
                            isInputActive = false
                            betAmount = 0
                        }
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(.all)
            }
            .onAppear {
                self.isInputActive = true
                self.betAmountString = ""
            }
    
            if showModalError {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                VStack {
                    Spacer()
                    ErrorPlacementView(errorMessage: $errorMessage, showModalError: $showModalError)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedCorners(radius: 50, corners: [.topLeft, .topRight]))
                        .shadow(radius: 10)
                    Spacer()
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showModalError)
                .onAppear {
                    HapticManager.triggerLightImpact()
                }
            }
        }
    }

    
    private func sportIcon(for sport: String) -> String {
        switch sport {
        case "Football": return "⚽️"
        case "Tennis": return "🎾"
        case "Basket": return "🏀"
        case "Rugby": return "🏉"
        case "Footus": return "🏈"
        default: return "🏅"
        }
    }
    
    
    private func resetState() {
        // Réinitialise les valeurs pour éviter des sélections persistantes
        chosenOption = ""
        selectedMarket = nil
        betAmount = 0
        betAmountString = ""
    }

    private func placeBet() {
        guard let market = selectedMarket else {
            showError("Sélectionnez un marché valide avant de placer un pari.")
            return
        }

        guard betAmount > 0 else {
            showError("Veuillez entrer un montant valide.")
            return
        }

        authViewModel.placeBet(market: market, chosenOption: chosenOption, stake: betAmount) { success, errorMessage in
            if success {
                print("Pari confirmé")
                showBetPlacementView = false
                SwiftUI.withAnimation {
                    showBetRecap = true
                }
            } else {
                showError(errorMessage ?? "Erreur inconnue.")
            }
        }
    }

    private func showError(_ message: String) {
        SwiftUI.withAnimation {
            errorMessage = message
            showModalError = true
        }
    }
}


#Preview {
    BetPlacementView(
        authViewModel: AuthViewModel(), showBetPlacementView: .constant(true),
        betAmount: .constant(10),
        chosenOption: .constant("Option 1"),
        selectedMarket: .constant(Market(id: "1", data: ["label": "Marché Test", "options": ["Option 1", "Option 2"], "correctAnswer": "Option 1", "status": "ouvert"])),
        showBetRecap: .constant(false)
    )
}


