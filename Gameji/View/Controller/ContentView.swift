//
//  ContentView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var globalSettings = GlobalSettings.shared
    @StateObject var authVM: AuthViewModel
    @State private var showIntro = true
    @State private var showWinXP = false
    
    var body: some View {
        ZStack {
            if showIntro {
                IntroView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showIntro = false
                        }
                    }
            } else if authVM.isFinishedConnecting {
                if authVM.isAuth {
                        MainTabView(authVM: authVM)
                    
                } else {
                    StartLoginView(authVM: authVM)
                }
            } else {
                IntroView()
            }
            
            if globalSettings.xpWin {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                VStack {
                    Spacer()
                    WinXpView(showWinXP: $showWinXP)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedCorners(radius: 50, corners: [.topLeft, .topRight]))
                        .shadow(radius: 10)
                    Spacer()
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showWinXP)
                .onAppear {
                    HapticManager.triggerLightImpact()
                }
            }
        }
    }
}

#Preview {
    ContentView(authVM: AuthViewModel())
}
