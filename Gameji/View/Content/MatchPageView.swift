//
//  MatchPageView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 01/11/2024.
//

import SwiftUI

// La vue MatchPageView, affichant les détails du match
struct MatchPageView: View {
    var market: Market
    var imageName: String  // Image du match

    // Propriété d’environnement pour fermer la vue
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(imageName) // Affiche l'image du match
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()

             

            // Contenu du match
            Text(market.label)
                .font(.title)
                .padding()

            Spacer()
                // Bouton de fermeture
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                }
                .padding([.top, .trailing], 16) // Place le bouton dans le coin supérieur droit
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}
