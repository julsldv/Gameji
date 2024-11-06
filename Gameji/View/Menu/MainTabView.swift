//
//  MainTabView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 04/11/2024.
//


import SwiftUI

struct MainTabView: View {
    @StateObject var authVM: AuthViewModel
    @State private var selectedTab = 1 // Onglet par défaut (flame)
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Contenu principal de chaque onglet
            Group {
                switch selectedTab {
                case 0:
                    SearchView()
                case 1:
                    MainView()
                case 2:
                    ChallengeView()
                default:
                    MainView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.05)) // Fond léger derrière le contenu

            // Barre d'onglets flottante
            if globalSettings.showTabBar {
                VStack {
                    Spacer()

                    HStack {
                        Spacer()
                        HStack {
                            Button(action: { selectedTab = 0 }) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedTab == 0 ? .white : .gray)
                            }
                            Spacer()
                            Button(action: { selectedTab = 1 }) {
                                Image(systemName: "flame")
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedTab == 1 ? .white : .gray)
                            }
                            Spacer()
                            Button(action: { selectedTab = 2 }) {
                                Image(systemName: "star")
                                    .font(.system(size: 20))
                                    .foregroundColor(selectedTab == 2 ? .white : .gray)
                            }
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 60)
                        .background(uiSettings.customBackColor1.opacity(0.8))
                        .cornerRadius(15)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        Spacer()
                    }
                    .padding(.bottom, 15)
                    .edgesIgnoringSafeArea(.bottom) // Ignore uniquement le bord inférieur pour la barre
                }
            }
        }
    }
}
