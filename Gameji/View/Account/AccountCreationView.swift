//
//  AccountCreationView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct AccountCreationView: View {
    
    @ObservedObject var uiSettings = UiSettings.shared
    @StateObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showAccountCreationView: Bool
    
    @State var step = 1
    @State var pseudo: String = ""
    @State var avatar: String = "homme"

    
    var body: some View {
        VStack {
            
            HStack {
                CloseButtonView {
                    print("fermeture de la création de compte")
                    
                }
                SpacerRectangle(width: 1, height: 1)
                
                Text("Création de compte")
                    .bold()
                    .font(.custom(uiSettings.customFontName, size: 20))
                    .foregroundStyle(uiSettings.customFontColor2)
                
                Spacer()
            }
            .padding()
            
            
            
            if step == 1 {
                //Content - début
                CreateAccountView_1(pseudo: $pseudo, step: $step, avatar: $avatar)
                //Content - fin
            }
            else if step == 2 {
                //Content - début
                CreateAccountView_2(authVM: authVM, pseudo: $pseudo, avatar: $avatar, step: $step)
                //Content - fin
            }
            else if step == 3 {
                //Content - début
                //Content - fin
            }
            else if step == 4 {
                //Content - début
                Text("Etape 4")
                //Content - fin
            }
            else if step == 5 {
                //Content - début
                Text("Etape 5")
                //Content - fin
            }
            else if step == 6 {
                //Content - début
                Text("Etape 6")
                //Content - fin
            }
            else {
                Text("Ici je mets ce que je veux pour d'autres cas.")
            }
            
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [uiSettings.customRedColor3, uiSettings.customRedColor3.opacity(0.4)]), startPoint: .top, endPoint: .bottom
                          )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    

    
}
#Preview {
    AccountCreationView(authVM: AuthViewModel(), showAccountCreationView: .constant(false))
}
