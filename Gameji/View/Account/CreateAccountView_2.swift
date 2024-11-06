//
//  CreateAccountView_2.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct CreateAccountView_2: View {
    
    @ObservedObject var uiSettings = UiSettings.shared
    @FocusState private var focus_email
    @FocusState private var focus_pwd
    @FocusState private var focus_pseudo
    @StateObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var email: String = ""
    @State var password: String = ""
    @State var balance: String = "0"
    @State var balanceTemp: String = "0"
    @Binding var pseudo: String
    @Binding var avatar: String
    
    @FocusState private var focus_pwd_verify // Etat focus vérification pwd
    @State var passwordVerify: String = "" // Variable d'état pour la vérification pwd
    @State var showError: Bool = false // Afficher une alerte en cas d'erreur de mot de passe
    @State var errorMessage: String = "" // Le message d'erreur à afficher
    
    @State var showConsentementView: Bool = false
    @State var showInfoPrivacyView: Bool = false
    @State var isInApp: Bool = false

    
    @Binding var step: Int
 
    var body: some View {
        VStack (spacing: 0) {
            ScrollView {
                SpacerRectangle(width: 1, height: 5)

                VStack {
                    
                
                VStack {
                    
                    TextField("E-Mail", text: $email)
                        .focused($focus_email)
                        .keyboardType(.emailAddress)
                    
                    
                }
                .font(.custom(uiSettings.customFontName, size: 14))
                .padding()
                .background(uiSettings.customFontColor2)
                .cornerRadius(15)
                .onAppear {
                    focus_email.toggle()
                }
                
                SpacerRectangle(width: 1, height: 1)
                
                VStack {
                    SecureField("Mot de passe", text: $password)
                        .focused($focus_pwd)
                        .keyboardType(.emailAddress)
                    
                }
                .font(.custom(uiSettings.customFontName, size: 14))
                .padding()
                .background(uiSettings.customFontColor2)
                .cornerRadius(15)
                
                
                SpacerRectangle(width: 1, height: 1)
                
                VStack {
                    SecureField("Confirmez le mot de passe", text: $passwordVerify)
                        .focused($focus_pwd)
                        .keyboardType(.emailAddress)
                    
                }
                .font(.custom(uiSettings.customFontName, size: 14))
                .padding()
                .background(uiSettings.customFontColor2)
                .cornerRadius(15)
                
                Spacer()
                
                SpacerRectangle(width: 1, height: 10)
                
                
                VStack {
                    Text("En créant un compte, j'accepte les")
                    
                    //Bouton consentement - Début
                    Button(action: {
                        showConsentementView = true
                    }) {
                        Text("termes et conditions")
                            .underline()
                    }
                    .fullScreenCover(isPresented: $showConsentementView) {
                        ConsentementView(showConsentementView: $showConsentementView, isInApp: $isInApp)
                    }
                    
                    //Bouton consentement - Fin
                    Text("et la")
                    
                    //Bouton confidentialité - Début
                    Button(action: {
                        showInfoPrivacyView = true
                    }) {
                        Text("politique de confidentialité")
                            .underline()
                    }
                    .fullScreenCover(isPresented: $showInfoPrivacyView) {
                        InfoPrivacyView(showInfoPrivacyView: $showInfoPrivacyView, isInApp: $isInApp)
                    }
                    
                    //Bouton confidentialité - Fin
                    
                    
                }
                .font(.custom(uiSettings.customFontName, size: 10))
                .foregroundColor(uiSettings.customFontColor2)
                .frame(alignment: .center)
                
                SpacerRectangle(width: 1, height: 10)
                
                
                ButtonLargeView(textButton: "Créer mon compte") {
                    if password == passwordVerify {
                        authVM.createUser(
                            email: self.email,
                            password: self.password,
                            pseudo: self.pseudo,
                            balance: self.balance
                        )
                    } else {
                        self.showError = true
                        self.errorMessage = "Les mots de passe ne correspondent pas."
                    }
                }.alert(isPresented: $showError) {
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
        .alert(authVM.errorString, isPresented: $authVM.showError) {
            Button("OK") {
                self.authVM.showError = false
                self.authVM.errorString = ""
            }
        }       
        
       
    }
}

#Preview {
    CreateAccountView_2(authVM: AuthViewModel(), pseudo: .constant("pseudo"), avatar: .constant("homme"), step: .constant(1))
}


