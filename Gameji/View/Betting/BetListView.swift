//
//  BetListView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 08/09/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct BetListView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    
    @State private var bets: [Bet] = []
    @State private var marketLabels: [String: String] = [:]
    @State private var isLoading = true
    @Binding var showBetListView: Bool
    @State private var userId: String?
    @State private var selectedTab = 0 // Index de l'onglet sélectionné
    @State private var marketSports: [String: String] = [:] // Dictionnaire pour stocker le sport de chaque marché
    @State private var marketCompetitions: [String: String] = [:] // Dictionnaire pour stocker la compétition de chaque marché
    @State private var marketCorrectAnswers: [String: String] = [:] // Dictionnaire pour stocker la réponse correcte de chaque marché

    var body: some View {
        VStack (spacing: 0) {
            
         
            
            if isLoading {
                ProgressView("Chargement des paris...")
            }
            else {
                // Utiliser la barre de tabulation personnalisée
                BetTapBarView(selectedTab: $selectedTab)
                    .padding(.top, 10)
                // Affichage des paris en fonction de l'onglet sélectionné
                if selectedTab == 0 {
                    // Vue pour les paris en cours
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(bets.filter { $0.status == "ongoing" }
                                        .sorted(by: { $0.date > $1.date })) { bet in // Trier par date
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(sportEmoji(for: marketSports[bet.marketId] ?? "Sport inconnu"))
                                          
                                        VStack(alignment: .leading) {
                                            Text(bet.chosenOption)
                                                .foregroundColor(.white)
                                                .bold()
                                            VStack(alignment: .leading) {
                                                Text(marketLabels[bet.marketId] ?? "Inconnu")
                                                Text(marketCompetitions[bet.marketId] ?? "Compétition inconnue")
                                            }
                                        }
                                        Spacer()
                                        
                                        VStack {
                                            Text("+\(bet.stake)")
                                        }
                                    }
                                   
                                }
                                .font(.custom(uiSettings.customFontName, size: 18))
                                .foregroundColor(.white.opacity(0.5))
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .frame(width: UIScreen.main.bounds.width * 0.90)
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await reloadBet()
                    }
                    
                    // Bouton de fermeture en bas
                    Button(action: {
                        showBetListView = false
                        globalSettings.showTabBar = true

                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    
                } else
                {
                    // Vue pour les paris terminés
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(bets.filter { $0.status == "ended" }
                                        .sorted(by: { $0.date > $1.date })) { bet in // Trier par date
                                let correctAnswer = marketCorrectAnswers[bet.marketId] ?? ""

                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(sportEmoji(for: marketSports[bet.marketId] ?? "Sport inconnu"))
                                            .font(.headline)
                                        
                                        VStack(alignment: .leading) {
                                            if bet.chosenOption == correctAnswer {
                                                Text(bet.chosenOption)
                                                    .foregroundColor(.white)
                                                    .bold()
                                            } else {
                                                HStack {
                                                    Text(bet.chosenOption)
                                                       
                                                        .strikethrough()
                                                    Text("(\(correctAnswer))")
                                                      
                                                }
                                            }
                                            VStack(alignment: .leading) {
                                                Text(marketLabels[bet.marketId] ?? "Inconnu")
                                                   
                                                Text(marketCompetitions[bet.marketId] ?? "Compétition inconnue")
                                                  
                                            }
                                        }
                                        Spacer()
                                        VStack {
                                            if bet.chosenOption == correctAnswer {
                                                Text("+\(bet.stake)")
                                                    .foregroundColor(.green)
                                                    .bold()
                                                    .font(.custom(uiSettings.customFontName, size: 18))
                                                  
                                            } else {
                                                Text("-\(bet.stake)")
                                                    .foregroundColor(.red)
                                                    .bold()
                                                    .font(.custom(uiSettings.customFontName, size: 18))
                                            }
                                        }
                                    }
                                }
                                .font(.custom(uiSettings.customFontName, size: 18))
                                .foregroundColor(.white.opacity(0.5))
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .frame(width: UIScreen.main.bounds.width * 0.90)
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await reloadBet()
                    }
                    
                    // Bouton de fermeture en bas
                    Button(action: {
                        showBetListView = false
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
        .onAppear {
            checkUserAndFetchBets()
        }
    }

    
    private func checkUserAndFetchBets() {
        if let currentUserId = Auth.auth().currentUser?.uid {
            self.userId = currentUserId
            fetchBetsForUser(userId: currentUserId)
        } else {
            self.isLoading = false
        }
    }
    
    // Fonction pour recharger les bets
    private func reloadBet() async {
        isLoading = true
        //Rechargement des bets
        isLoading = false
    }

    private func sportEmoji(for sport: String) -> String {
        switch sport {
        case "Football":
            return "⚽️"
        case "Tennis":
            return "🎾"
        case "Basket":
            return "🏀"
        case "Rugby":
            return "🏉"
        case "Footus":
            return "🏈"
        default:
            return "🏅" // Symbole par défaut pour les autres sports
        }
    }

    private func fetchBetsForUser(userId: String) {
        FirebaseManager.shared.betsRef
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    self.isLoading = false
                    return
                }

                guard let documents = snapshot?.documents, !documents.isEmpty else {
                    self.isLoading = false
                    return
                }

                self.bets = documents.map { Bet(id: $0.documentID, data: $0.data()) }
                fetchMarketLabels()
                self.isLoading = false
            }
    }
    
    private func fetchMarketLabels() {
        let marketIds = Set(bets.map { $0.marketId })
        for marketId in marketIds {
            FirebaseManager.shared.marketDoc(marketId).getDocument { document, error in
                if let error = error {
                    print("Erreur lors de la récupération du marché \(marketId): \(error.localizedDescription)")
                    return
                }

                if let document = document, document.exists {
                    let data = document.data()
                    let label = data?["label"] as? String ?? "Inconnu"
                    let sport = data?["sport"] as? String ?? "Sport inconnu"
                    let competition = data?["competition"] as? String ?? "Compétition inconnue"
                    let correctAnswer = data?["correctAnswer"] as? String ?? "" // Récupérer la réponse correcte

                    self.marketLabels[marketId] = label
                    self.marketSports[marketId] = sport
                    self.marketCompetitions[marketId] = competition
                    self.marketCorrectAnswers[marketId] = correctAnswer // Stocker la réponse correcte dans le dictionnaire
                } else {
                    print("Le marché avec l'ID \(marketId) est introuvable.")
                }
            }
        }
    }
}





