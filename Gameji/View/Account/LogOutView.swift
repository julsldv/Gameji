//
//  LogOutView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct LogOutView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showLogOutView: Bool
    
    var body: some View {
        VStack {
            Text("Voulez-vous vous déconnecter ?")
                .font(.system(size: 20, design: .rounded))
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(uiSettings.customFontColor1)
                .background(Color.clear)
            
            SpacerRectangle(width: 1, height: 10)

            ButtonLargeView(textButton: "Déconnecter") {
                FirebaseManager.shared.logOut()
            }
            
            SpacerRectangle(width: 1, height: 2)
            
            CloseModalButtonView(textButton: "Annuler") {
                showLogOutView = false
            }
            
            SpacerRectangle(width: 1, height: 1)
        }
        .multilineTextAlignment(.center)
        .background(uiSettings.customBackColor1)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(uiSettings.customFontColor2.opacity(0.3), lineWidth: 2)
        )
        .padding(40)
    }
}


#Preview {
    LogOutView(showLogOutView: .constant(false))
}
