//
//  StartLoginView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct StartLoginView: View {
    @StateObject var authVM: AuthViewModel
    @ObservedObject var uiSettings = UiSettings.shared
    @State var showConnectView = false
    @State var showAccountCreationView = false
    
    var body: some View {
       
            
            // Contenu principal
            VStack {
                VStack(spacing: 5) {
                    Spacer()
                    
                    Image("betclic")
                        .resizable()
                        .frame(width: 130, height: 50)
                
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    ButtonLargeView(textButton: "Inscription") {
                        showAccountCreationView = true
                    }
                    .fullScreenCover(isPresented: $showAccountCreationView) {
                        AccountCreationView(authVM: AuthViewModel(), showAccountCreationView: $showAccountCreationView)
                    }
                    
                    SpacerRectangle(width: 1, height: 2)
                    
                    CloseModalButtonView(textButton: "Connexion") {
                        showConnectView = true
                    }
                    .fullScreenCover(isPresented: $showConnectView) {
                        ConnectView(authVM: AuthViewModel(), showConnectView: $showConnectView)
                    }
                }
                .frame(height: 150)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [uiSettings.customRedColor3, uiSettings.customRedColor3.opacity(0.4)]), startPoint: .top, endPoint: .bottom
                              )
            )
        
    }
}

#Preview {
    StartLoginView(authVM: AuthViewModel())
}

