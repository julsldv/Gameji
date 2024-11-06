//
//  MenuView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 31/10/2024.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    
    @State private var selectedButton: String? = "" // Contient "Prematch" ou "Live" si l'un des deux est sélectionné
    @Binding var selectedSport: String // Choix de sport sélectionné
    @Binding var showSportsList: Bool // Contrôle de l'affichage de la liste des sports
    
    var defaultSport = "Sports" // Valeur par défaut pour réinitialiser le choix du sport
    
    var body: some View {
        HStack(spacing: 5) {
            // Bouton de réinitialisation qui apparaît si Prematch, Live, ou un sport est sélectionné
            if selectedButton == "Prematch" || selectedButton == "Live" || selectedSport != defaultSport {
                Button(action: {
                    withAnimation {
                        selectedButton = ""
                        selectedSport = defaultSport
                        HapticManager.triggerHeavyImpact()
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Circle().stroke(Color.gray.opacity(0.8), lineWidth: 1).background(Color.clear))
                        .clipShape(Circle())
                    
                }
                .transition(.opacity.combined(with: .scale))
            }
            
            // Boutons Prematch et Live
            if selectedButton != "Live" {
                Button(action: {
                    withAnimation {
                        selectedButton = "Prematch"
                        HapticManager.triggerHeavyImpact()

                    }
                }) {
                    Text("Prematch")
                        .font(.custom(uiSettings.customFontName, size: 15))
                        .bold()
                        .foregroundColor(uiSettings.customFontColor2)
                        .padding(5)
                        .padding(.horizontal, 10)
                }
                .buttonStyle(MenuButtonStyle(isSelected: selectedButton == "Prematch"))
                .transition(.opacity.combined(with: .scale))
            }
            
            if selectedButton != "Prematch" {
                Button(action: {
                    withAnimation {
                        selectedButton = "Live"
                        HapticManager.triggerHeavyImpact()

                    }
                }) {
                    Text("Live")
                        .font(.custom(uiSettings.customFontName, size: 15))
                        .bold()
                        .foregroundColor(uiSettings.customFontColor2)
                        .padding(5)
                        .padding(.horizontal, 10)
                }
                .buttonStyle(MenuButtonStyle(isSelected: selectedButton == "Live"))
                .transition(.opacity.combined(with: .scale))
            }
            
            // Bouton Sports avec flèche et action spéciale pour afficher la liste des sports
            Button(action: {
                showSportsList = true
                HapticManager.triggerHeavyImpact()
                globalSettings.showTabBar = false

            }) {
                HStack {
                    Text(selectedSport)
                    Image(systemName: "chevron.down")
                }
                .font(.custom(uiSettings.customFontName, size: 15))
                .bold()
                .foregroundColor(uiSettings.customFontColor2)
                .padding(5)
                .padding(.horizontal, 10)
            }
            .buttonStyle(MenuButtonStyle(isSelected: selectedSport != defaultSport)) // Bouton "sport" apparaît comme sélectionné si un sport différent est choisi
            
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}




// Preview
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(selectedSport: .constant("Tennis"), showSportsList: .constant(false))
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
