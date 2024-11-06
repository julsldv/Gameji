//
//  SmallCardView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 09/09/2024.
//


import SwiftUI


struct SmallCardView: View {
    var market: Market
    @Binding var chosenOption: String
    var showBetPlacement: (Market, String) -> Void
    @ObservedObject var uiSettings: UiSettings
    @ObservedObject var globalSettings = GlobalSettings.shared

    // État pour gérer l'effet d'enfoncement et l'option sélectionnée
    @State private var isPressed = false
    @State private var randomOption: String?
    @State private var randomImage: String // Image de fond aléatoire

    init(market: Market, chosenOption: Binding<String>, showBetPlacement: @escaping (Market, String) -> Void, uiSettings: UiSettings) {
        self.market = market
        self._chosenOption = chosenOption
        self.showBetPlacement = showBetPlacement
        self.uiSettings = uiSettings
        
        // Choisit une image de fond aléatoire parmi bgsmall1, bgsmall2, bgsmall3
        _randomImage = State(initialValue: ["bgsmall1", "bgsmall2", "bgsmall3", "bgsmall4", "bgsmall5", "bgsmall6"].randomElement() ?? "bgsmall1")
        _randomOption = State(initialValue: market.options.randomElement())
    }

    var body: some View {
        Button(action: {
            if let option = randomOption {
                showBetPlacement(market, option)
                globalSettings.showTabBar = false
            }
        }) {
            VStack(spacing: 0) {
                VStack(alignment: .center, spacing: 10) {
                    HStack(spacing: 5) {
                        Text(sportIcon(for: market.sport))
                            .font(.custom(uiSettings.customFontName, size: 14))
                        Text(market.competition)
                            .foregroundColor(.white)
                            .bold()
                            .font(.custom(uiSettings.customFontName, size: 14))
                    }
                    .padding(8)
                    .padding([.top, .leading], 10)
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        HStack {
                            Spacer()
                            Text(market.label)
                                .font(.custom(uiSettings.customFontName, size: 14))
                                .multilineTextAlignment(.center)
                                .bold()
                                .foregroundColor(uiSettings.customFontColor2)
                            Spacer()
                        }
                        
                        if let option = randomOption {
                            HStack {
                                Spacer()
                                Text(option)
                                    .font(.custom(uiSettings.customFontName, size: 14))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(uiSettings.customFontColor1)
                                    .bold()
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(uiSettings.customOddkColor1)
                                    .cornerRadius(5)
                                    .lineLimit(2)
                                Spacer()
                            }
                        } else {
                            Text("Aucune option disponible")
                                .font(.custom(uiSettings.customFontName, size: 14))
                                .foregroundColor(.gray)
                                .italic()
                                .frame(width: 95, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                    .padding(10)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(12)
                }
            }
           .background(
                Image(randomImage)
                    .resizable()
                    .frame(width: 140, height: 200)
                    .scaledToFill()
                    .cornerRadius(12)
                    .opacity(0.5)
            )
            
            .frame(width: 140, height: 200)
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
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
    
    private func sportIcon(for sport: String) -> String {
        switch sport {
        case "Football": return "⚽️"
        case "Tennis": return "🎾"
        case "Basket": return "🏀"
        case "Rugby": return "🏉"
        case "Footus": return "🏈"
        case "Natation": return "🏊🏻‍♂️"
        case "Formule1": return "🏎️"
        default: return "🏅"
        }
    }
}


struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        let testData: [String: Any] = [
            "label": "Match de la Semaine",
            "options": ["Équipe A", "Équipe B", "Équipe C"],
            "correctAnswer": "Équipe A",
            "status": "ouvert",
            "sport": "football",
            "competition": "Ligue 1",
            "special": true
        ]
        
        let testMarket = Market(id: "1", data: testData)
        
        SmallCardView(
            market: testMarket,
            chosenOption: .constant("Équipe A"),
            showBetPlacement: { market, option in
                print("Option choisie : \(option) pour le marché \(market.label)")
            },
            uiSettings: UiSettings.shared
        )
        .previewLayout(.sizeThatFits)
    }
}
