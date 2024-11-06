//
//  MarketView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 09/09/2024.
//

import SwiftUI

struct MarketView: View {
    var market: Market
    @Binding var chosenOption: String
    var showBetPlacement: (Market, String) -> Void
    @ObservedObject var uiSettings: UiSettings
    @ObservedObject var globalSettings = GlobalSettings.shared

    @State private var selectedOption: String? = nil
    @State private var randomImage: String
    @State private var gradientRotation: Double = 0.0 // Pour animer le dégradé

    // Liste des images disponibles
    private static let images = [
        "basket1", "basket2", "basket3", "basket4",
        "foot1", "foot2", "foot3", "foot4", "foot5", "foot6", "foot7", "foot8", "foot9", "foot10",
        "tennis1", "tennis2",
        "rugby1", "rugby2", "rugby3",
        "usfoot1", "usfoot2",
        "natation1",
        "formule1"
    ]
    
    init(market: Market, chosenOption: Binding<String>, showBetPlacement: @escaping (Market, String) -> Void, uiSettings: UiSettings) {
        self.market = market
        self._chosenOption = chosenOption
        self.showBetPlacement = showBetPlacement
        self.uiSettings = uiSettings
        _randomImage = State(initialValue: MarketView.selectImage(for: market.sport, from: MarketView.images))
    }

    static func selectImage(for sport: String, from images: [String]) -> String {
        let prefix: String
        switch sport.lowercased() {
        case "football": prefix = "foot"
        case "tennis": prefix = "tennis"
        case "basket": prefix = "basket"
        case "rugby": prefix = "rugby"
        case "foot us": prefix = "usfoot"
        case "natation": prefix = "natation"
        case "formule 1": prefix = "formule1"
        default: return images.randomElement() ?? "foot1"
        }
        return images.filter { $0.hasPrefix(prefix) }.randomElement() ?? "foot1"
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Image en arrière-plan en fonction du sport
            Image(randomImage)
                .resizable()
                .scaledToFill()
                .clipped()
                .cornerRadius(12)
                
            VStack {
                // Affichage du sport et de la compétition
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

                // Détails du marché
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
                                    Text(option)
                                        .font(.custom(uiSettings.customFontName, size: 14))
                                        .foregroundColor(uiSettings.customFontColor1)
                                        .bold()
                                        .padding(5)
                                        .frame(width: 95, height: 40)
                                        .background(uiSettings.customOddkColor1)
                                        .cornerRadius(5)
                                        .scaleEffect(selectedOption == option ? 0.90 : 1.0)
                                        .onTapGesture {}
                                        .simultaneousGesture(
                                            DragGesture(minimumDistance: 0)
                                                .onChanged { _ in selectedOption = option }
                                                .onEnded { _ in
                                                    selectedOption = nil
                                                    showBetPlacement(market, option)
                                                    globalSettings.showTabBar = false
                                                }
                                        )
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
        .frame(width: 350, height: 380)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [uiSettings.customBackColor2, Color.gray, uiSettings.customOddkColor1, uiSettings.customBackColor2]),
                        center: .center,
                        angle: .degrees(gradientRotation)
                    ),
                    lineWidth: 5
                )
                .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false), value: gradientRotation)
        )
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
        .onAppear {
            // Démarrer l'animation en augmentant continuellement l'angle de rotation
            gradientRotation = 360
        }
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
struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        let testData: [String: Any] = [
            "label": "Match de la semaine avec un titre un peu long ?",
            "options": ["Équipe A", "Équipe B", "Équipe C"],
            "correctAnswer": "Équipe A",
            "status": "ouvert",
            "sport": "Football",
            "competition": "Ligue 1"
        ]
        
        let testMarket = Market(id: "1", data: testData)
        
        MarketView(
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

