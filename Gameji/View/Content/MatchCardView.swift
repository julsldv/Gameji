//
//  MatchCardView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 03/11/2024.
//

import SwiftUI

struct MatchCardView: View {
    var market: Market
    @Binding var chosenOption: String
    var showBetPlacement: (Market, String) -> Void
    @ObservedObject var uiSettings: UiSettings
    @ObservedObject var globalSettings = GlobalSettings.shared
    
    @State private var selectedOption: String? = nil
    @State private var randomImage: String
    
    init(market: Market, chosenOption: Binding<String>, showBetPlacement: @escaping (Market, String) -> Void, uiSettings: UiSettings) {
        self.market = market
        self._chosenOption = chosenOption
        self.showBetPlacement = showBetPlacement
        self.uiSettings = uiSettings
        // Appel à la fonction indépendante dans ImageSelector
        self._randomImage = State(initialValue: ImageSelector.selectImage(for: market.sport))
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Utilisation de l'image aléatoire sélectionnée
            Image(randomImage)
                .resizable()
                .scaledToFill()
                .clipped()
                .cornerRadius(12)
            
            // Reste du code de MatchCardView
            VStack {
                HStack(spacing: 5) {
                    Text(sportIcon(for: market.sport))
                        .font(.custom(uiSettings.customFontName, size: 14))
                    Text(market.sport)
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom(uiSettings.customFontName, size: 14))
                    Text("-")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom(uiSettings.customFontName, size: 14))
                    Text(market.competition)
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom(uiSettings.customFontName, size: 14))
                }
                .padding(8)
                .background(Color.black.opacity(0.3))
                .cornerRadius(5)
                .padding([.top, .leading], 10)
                
                Spacer()
                
                // Détails du marché (comme précédemment)
                VStack(alignment: .center) {
                    VStack (spacing: 0) {
                        HStack {
                            Spacer()
                            Text(market.label)
                                .font(.custom(uiSettings.customFontName, size: 20))
                                .bold()
                                .lineLimit(2)
                                .foregroundColor(uiSettings.customFontColor2)
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                            Spacer()
                        }
                        .padding(5)
                        
                        HStack {
                            Spacer()
                            ForEach(market.options, id: \.self) { option in
                                if market.status == "ouvert" {
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            selectedOption = option
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            selectedOption = nil
                                            globalSettings.showTabBar = false
                                            showBetPlacement(market, option)
                                            HapticManager.triggerLightImpact()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                HapticManager.triggerLightImpact()
                                            }
                                        }
                                    }) {
                                        Text(option)
                                            .font(.custom(uiSettings.customFontName, size: 14))
                                            .foregroundColor(uiSettings.customFontColor1)
                                            .bold()
                                            .padding(5)
                                            .frame(width: 95, height: 40)
                                            .background(uiSettings.customOddkColor1)
                                            .cornerRadius(5)
                                            .modifier(ShakeEffect(animatableData: selectedOption == option ? 1 : 0))
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                } else {
                                    Text(option)
                                        .font(.custom(uiSettings.customFontName, size: 14))
                                        .foregroundColor(uiSettings.customFontColor1)
                                        .bold()
                                        .padding(5)
                                        .frame(width: 95, height: 40)
                                        .background(uiSettings.customOddkColor1)
                                        .cornerRadius(5)
                                }
                            }
                            Spacer()
                        }
                        .padding(5)
                    }
                    .padding(10)
                }
                .background(Color.black.opacity(0.4))
            }
        }
        .frame(height: 240)
        .frame(maxWidth: .infinity)
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [uiSettings.customBackColor2, Color.gray, uiSettings.customOddkColor1]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 5
                )
        )
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
    
    private func sportIcon(for sport: String) -> String {
        switch sport.lowercased() {
        case "football": return "⚽️"
        case "tennis": return "🎾"
        case "basket": return "🏀"
        case "rugby": return "🏉"
        case "foot us": return "🏈"
        case "natation": return "🏊🏻‍♂️"
        case "formule 1": return "🏎️"
        default: return "🏅"
        }
    }
}


// Preview avec des données de test pour Market
struct MatchCardView_Previews: PreviewProvider {
    static var previews: some View {
        let testData: [String: Any] = [
            "label": "Match de la Semaine avec un titre un peu long ?",
            "options": ["Équipe A", "Équipe B", "Équipe C"],
            "correctAnswer": "Équipe A",
            "status": "ouvert",
            "sport": "Football",
            "competition": "Ligue 1"
        ]
        
        let testMarket = Market(id: "1", data: testData)
        
        MatchCardView(
            market: testMarket,
            chosenOption: .constant("Équipe A"),
            showBetPlacement: { market, option in
                print("Option choisie : \(option) pour le marché \(market.label)")
            },
            uiSettings: UiSettings()
        )
        .previewLayout(.sizeThatFits)
    }
}

