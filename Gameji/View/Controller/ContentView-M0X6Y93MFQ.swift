//
//  ContentView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if showIntro {
            IntroView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showIntro = false
                    }
                }
        } else if authVM.isFinishedConnecting {
            if authVM.isAuth {
                MainView()
            } else {
                StartLoginView(authVM: authVM)
            }
        } else {
            IntroView()
        }
    }
}

#Preview {
    ContentView()
}
