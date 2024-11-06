//
//  DeleteAccountView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authVM = AuthViewModel()
    @Binding var showDeleteAccountView: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Confirmez-vous la suppression de votre compte ?")
                .font(.system(size: 20, design: .rounded))
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(uiSettings.customFontColor1)
                .background(Color.clear)
                      
            SpacerRectangle(width: 1, height: 10)
            
            
            ButtonLargeView(textButton: "Supprimer") {
                authVM.deleteUserAccount { success, message in
                    if success {
                        print("Suppresion du compte succés")
                    } else {
                        print("Suppresion du compte erreur")
                    }
                }            }
            
            SpacerRectangle(width: 1, height: 2)

            CloseModalButtonView(textButton: "Annuler") {
                showDeleteAccountView = false
            }
            
            SpacerRectangle(width: 1, height: 1)
        }
        .padding(40)
    }
}


#Preview {
    DeleteAccountView(showDeleteAccountView: .constant(false))
}
