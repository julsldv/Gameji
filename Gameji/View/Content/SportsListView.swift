//
//  SportsListView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 31/10/2024.
//

import SwiftUI

struct SportsListView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    @Binding var selectedSport: String
    @Binding var showSportsList: Bool
    
    // Liste des sports spécifiée
    let sports = [
        "Football", "Tennis", "Basket", "Rugby", "Formule 1", "Foot US",
        "Natation", "Escrime", "Baseball", "Hockey",
        "Tennis de table", "Moto GP"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sélectionner un Sport")
                .font(.custom(uiSettings.customFontName, size: 18))
                .foregroundColor(.white.opacity(0.5))
                .bold()
                .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(sports, id: \.self) { sport in
                        Button(action: {
                            selectedSport = sport
                            showSportsList = false
                            globalSettings.showTabBar = true
                        }) {
                            Text(sport)
                                .font(.custom(uiSettings.customFontName, size: 18))
                                .foregroundColor(.white.opacity(0.5))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
            Spacer()
            
            // Bouton de fermeture en bas
            Button(action: {
                showSportsList = false
                globalSettings.showTabBar = true
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    SportsListView(selectedSport: .constant("Tennis"), showSportsList: .constant(false))
        .background(.black)
}
