//
//  TestView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()
    @Binding var showTestView: Bool
    @State private var balanceInput: Int = 0
    @State private var showProfilView = false
    @State private var showBetListView = false
    
    var body: some View {
                ScrollView {
                    VStack {
                        
                        //Fermeture de la page
                        HStack {
                            CloseButtonView {
                                print("fermeture de la page test")
                            }
                            Spacer()
                            Text("Page de test")
                            Spacer()
                        }
                        .padding()
                        //Fermeture de la page
                        
                        SpacerRectangle(width: 1, height: 1)
                        
                        
                        //Afficher le header
                 //       TopView(showProfilView: $showProfilView, showBetListView: $showBetListView)
                        //Afficher les header
                        
                        //Udpdater les balances
                        VStack(spacing: 20) {

                            TextField("Montant pour Balance", text: Binding(
                                get: { String(balanceInput) },
                                set: { newValue in
                                    if let intValue = Int(newValue) {
                                        balanceInput = intValue
                                    }
                                }
                            ))
                            .foregroundColor(uiSettings.customFontColor1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .padding()


                            TextField("Montant pour Balance temp", text: Binding(
                                get: { String(balanceInput) },
                                set: { newValue in
                                    if let intValue = Int(newValue) {
                                        balanceInput = intValue
                                    }
                                }
                            ))
                            .foregroundColor(uiSettings.customFontColor1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .padding()

                            ButtonLargeView(textButton: "Mettre à jour la balance") {
                                authViewModel.updateBalances(balance: balanceInput)
                            }
                        }
                        .foregroundColor(uiSettings.customFontColor2)
                        .padding()
                        //Udpdater les balances
                        
                        
                        SpacerRectangle(width: 1, height: 1)
                        
                        
                    }
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [uiSettings.customMainColor1, uiSettings.customMainColor2]), startPoint: .topLeading, endPoint: .bottomTrailing
                                  )
                )
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(showTestView: .constant(true))
    }
}
