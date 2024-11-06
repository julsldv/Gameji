//
//  BalanceTempView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//
/*
import SwiftUI

struct BalanceTempView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()

    @State private var progress: Double = 0
    @State private var showBalance: Bool = false // Contrôle de la visibilité de la valeur

    let maxWidth: CGFloat = 150 // Largeur fixe de la jauge
    let maxValue: Double = 1000 // Valeur maximale de la jauge

    var body: some View {
        VStack {
            // Afficher un indicateur de chargement jusqu'à ce que les données de l'utilisateur soient chargées
            if authViewModel.isFinishedConnecting && authViewModel.isAuth {
                ZStack(alignment: .leading) {
                    // Couche de fond de la barre de progression
                    Rectangle()
                        .fill(uiSettings.customFontColor2.opacity(0.1))
                        .frame(width: maxWidth, height: 25) // Largeur fixe de 150
                        .cornerRadius(10)

                    // Couche de remplissage de la barre de progression
                    Rectangle()
                        .fill(uiSettings.customMainColor1.opacity(0.6))
                        .frame(width: CGFloat(progress / maxValue) * maxWidth, height: 25) // Ajuster la largeur en fonction de la progression
                        .cornerRadius(10)
                        .animation(.easeInOut(duration: 2.0), value: progress) // Animation pour le remplissage

                    // Texte de la balance, affiché à droite sur la partie vide, ou par-dessus si la jauge est pleine
                    if showBalance {
                        GeometryReader { geometry in
                            let filledWidth = CGFloat(progress / maxValue) * maxWidth
                            let textXPosition = min(filledWidth + 30, maxWidth - 25) // Positionner à droite de la partie remplie ou au maximum à droite

                            Text(String(authViewModel.userBalanceTemp))
                                .font(.system(size: 18, design: .rounded))
                                .bold()
                                .foregroundColor(uiSettings.customFontColor2)
                                .position(x: textXPosition, y: geometry.size.height / 2) // Centrer verticalement le texte
                        }
                        .frame(width: maxWidth, height: 25) // Limite la taille de la GeometryReader
                    }
                }
                .frame(width: maxWidth) // Encapsuler dans une largeur fixe
                .padding(5)
                .onAppear {
                    // Déclencher l'animation de remplissage lors de l'affichage initial
                    withAnimation {
                        progress = min(Double(authViewModel.userBalanceTemp), maxValue)
                    }

                    // Attendre la fin de l'animation avant d'afficher la valeur
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        showBalance = true
                    }
                }
                .onReceive(authViewModel.$userBalanceTemp) { newBalance in
                    // Mettre à jour la progression chaque fois que `userBalanceTemp` change
                    withAnimation(.easeInOut(duration: 2.0)) {
                        progress = min(Double(newBalance), maxValue)
                    }

                    // Réinitialiser la visibilité du texte et attendre la fin de l'animation
                    showBalance = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        showBalance = true
                    }
                }
            } else {
                // Afficher un indicateur de chargement ou un message
                Text("Chargement...")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 25)
        .padding(10)
        .background(uiSettings.customFontColor2.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    BalanceTempView()
}
*/
