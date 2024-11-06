//
//  ConnectView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct ConnectView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @FocusState private var focus
    @FocusState private var focus_pwd
    @StateObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var email: String = ""
    @State var password: String = ""
    @Binding var showConnectView: Bool
 
    var body: some View {
    
            
            // Contenu principal
            VStack (spacing: 0) {
                HStack {
                    CloseButtonView {
                        print("fermeture de la connexion")
                    }
                    SpacerRectangle(width: 1, height: 1)
                    
                    Text("Connectez-vous")
                        .bold()
                        .font(.custom(uiSettings.customFontName, size: 20))
                        .foregroundStyle(uiSettings.customFontColor2)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    SpacerRectangle(width: 1, height: 50)
                    
                    VStack {
                        TextField("E-Mail", text: $email)
                            .focused($focus)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(uiSettings.customFontColor2)
                            .cornerRadius(15)
                            .onAppear {
                                focus.toggle()
                            }
                        
                        SpacerRectangle(width: 1, height: 1)
                        
                        SecureField("Mot de passe", text: $password)
                            .focused($focus_pwd)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(uiSettings.customFontColor2)
                            .cornerRadius(15)

                        SpacerRectangle(width: 1, height: 20)
                        
                        ButtonLargeView(textButton: "Connexion") {
                            authVM.signIn(email: self.email, password: self.password)
                        }
                    }
                    .font(.custom(uiSettings.customFontName, size: 20))
                    .foregroundStyle(Color.gray)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    
                    Spacer()
                }
            }
            .alert(authVM.errorString, isPresented: $authVM.showError) {
                Button("OK") {
                    self.authVM.showError = false
                    self.authVM.errorString = ""
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [uiSettings.customRedColor3, uiSettings.customRedColor3.opacity(0.4)]), startPoint: .top, endPoint: .bottom
                              )
            )
        
    }
}

#Preview {
    ConnectView(authVM: AuthViewModel(), showConnectView: .constant(false))
}

