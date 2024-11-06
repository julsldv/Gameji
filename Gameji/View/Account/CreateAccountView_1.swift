//
//  CreateAccountView_1.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct CreateAccountView_1: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Environment(\.presentationMode) var presentationMode
    let avatars = ["homme", "homme2", "femme"]
    @FocusState private var focus_pseudo
    @Binding var pseudo: String
    @State var showError: Bool = false // Afficher une alerte en cas d'erreur de mot de passe
    @State var errorMessage: String = "" // Le message d'erreur à afficher
    @Binding var step: Int
    @Binding var avatar: String

    var body: some View {
        VStack (spacing: 0) {
            ScrollView {
                SpacerRectangle(width: 1, height: 5)
                
                VStack {
                
                SpacerRectangle(width: 1, height: 10)
                
                
                VStack {
                    TextField("Pseudo", text: $pseudo)
                        .font(.custom(uiSettings.customFontName, size: 14))
                        .focused($focus_pseudo)
                        .keyboardType(.emailAddress)
                    
                    
                }
                .padding()
                .background(uiSettings.customFontColor2)
                .cornerRadius(15)
                .onAppear {
                    focus_pseudo.toggle()
                }
                
                SpacerRectangle(width: 1, height: 10)
                
                ButtonLargeView(textButton: "Etape suivante") {
                    if isPseudoValid() {
                        print("Pseudo : \(pseudo)")
                        step = 2
                    } else {
                        // Le pseudo n'est pas renseigné, affichez une erreur ou alertez l'utilisateur
                        showError = true
                        errorMessage = "Veuillez renseigner un pseudo."
                    }
                }  .alert(isPresented: $showError) {
                    Alert(title: Text("Erreur"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
            }
                .font(.custom(uiSettings.customFontName, size: 20))
                .foregroundStyle(uiSettings.customFontColor1)
                .bold()
                .multilineTextAlignment(.leading)
               
        }
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(width: UIScreen.main.bounds.width * 0.8)
        
    }
    
    func isPseudoValid() -> Bool {
        return !pseudo.isEmpty
    }

    
}

#Preview {
    VStack {
        CreateAccountView_1(pseudo: .constant("Pseudo"), step: .constant(0), avatar: .constant("avatar"))
    }
    
    }
