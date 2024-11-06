//
//  ProfilView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct ProfilView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()
    @ObservedObject var globalSettings = GlobalSettings.shared

    @State private var showExportView = false
    @State private var showInfoPrivacyView = false
    @State private var showConsentementView = false
    @State var showDeleteAccountView = false
    @Binding var showProfilView: Bool
    @State private var tapCount = 0
    @State private var showTestView = false
    @State private var showLogOutView = false
    @State private var isInApp = true
    @State private var showManageCategoriesView = false
    let emailAddress = "ContactMyImmoZ@gmail.com"


    var body: some View {
        ZStack {
            VStack (spacing: 20) {
                Text("Mon compte")
                    .font(.custom(uiSettings.customFontName, size: 18))
                    .foregroundColor(.white.opacity(0.5))
                    .bold()
                    .padding(.top, 20)
                
                ScrollView {
                    VStack  (spacing: 0) {
                        VStack {
                            HStack (alignment: .center){
                                Spacer()
                                VStack {
                                    Text(String(authViewModel.userPseudo.first ?? "J"))
                                        .font(.system(size: 30, weight: .bold))
                                        .foregroundColor(uiSettings.customFontColor2)
                                        .bold()
                                        .padding(10)
                                    
                                }
                                .padding(10)
                                .background(
                                    Image("bgsmall1")
                                        .resizable()
                                        .scaledToFill()
                                        .edgesIgnoringSafeArea(.all)
                                )
                                .cornerRadius(20)
                                
                                
                                VStack(alignment: .leading) {
                                    Text(authViewModel.userPseudo)
                                        .font(.custom(uiSettings.customFontName, size: 16))
                                        .foregroundColor(.white.opacity(0.5))
                                        
                                    
                                    Text(authViewModel.userEmail)
                                        .font(.custom(uiSettings.customFontName, size: 16))
                                        .foregroundColor(.white.opacity(0.5))
                                        
                                }
                                .accentColor(uiSettings.customFontColor1)
                                
                                Spacer()
                            }
                            .padding(15)
                            
                            SpacerRectangle(width: 1, height: 30)
                            
                            Divider()
                                .background(.white)
                            
                            Spacer()
                            
                            VStack {
                                
                                // BOUTON DONNER SON AVIS DANS LE STORE - DEBUT
                                Button(action: {
                                    // Effectuer l'action souhaitée lorsque le bouton est cliqué
                                    if let url = URL(string: "itms-apps://itunes.apple.com/app/6462700029?action=write-review") {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "star")
                                        SpacerRectangle(width: 1, height: 1)
                                        Text("Noter l'application")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        SpacerRectangle(width: 1, height: 1)
                                    }
                                    
                                }   .padding(15)
                                
                                Divider()
                                    .background(.white)
                                
                                // BOUTON DONNER SON AVIS DANS LE STORE - FIN
                                
                                // Politique de confidentialité - début
                                NavigationLink(destination: InfoPrivacyView(showInfoPrivacyView: $showInfoPrivacyView, isInApp: $isInApp)) {
                                    HStack {
                                        Image(systemName: "doc.plaintext")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                        
                                        Text("Politique de confidentialité")
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                    }
                                    
                                }   .padding(15)
                                
                                Divider()
                                    .background(.white)
                                
                                // Termes et conditions - début
                                NavigationLink(destination: ConsentementView(showConsentementView: $showConsentementView, isInApp: $isInApp)) {
                                    HStack {
                                        Image(systemName: "doc.text")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                        
                                        Text("Termes et conditions")
                                        
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                    }
                                    
                                }   .padding(15)
                                
                                Divider()
                                    .background(.white)
                                
                                // ENVOYER UN MAIL - DEBUT
                                Button(action: {
                                    if let emailURL = URL(string: "mailto:\(emailAddress)") {
                                        UIApplication.shared.open(emailURL)
                                    }
                                })  {
                                    HStack {
                                        Image(systemName: "message")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                        
                                        Text("Nous contacter")
                                        
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                    }
                                    
                                }
                                .padding(15)
                                
                                Divider()
                                    .background(.white)
                                
                                //SUPPRESSION DE COMPTE - DEBUT
                                Button(action: {
                                    withAnimation {
                                        showDeleteAccountView = true
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "xmark.bin")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                        
                                        Text("Supprimer mon compte")
                                        
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                    }
                                    
                                    
                                }  .padding(15)
                                
                                //SUPPRESSION DE COMPTE - FIN
                                
                                Divider()
                                    .background(.white)
                                
                                
                                // Se déconnecter - début
                                Button(action: {
                                    withAnimation {
                                        showLogOutView = true
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "lock")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                        
                                        Text("Se déconnecter")
                                        
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                        
                                        
                                        SpacerRectangle(width: 1, height: 1)
                                    }
                                    
                                }  .padding(15)
                                
                                
                            }
                            
                            
                            .font(.custom(uiSettings.customFontName, size: 16))
                            .foregroundColor(.white.opacity(0.5))
                            
                            
                            
                            
                            
                            
                            
                        }
                        SpacerRectangle(width: 1, height: 10)
                        
                        Spacer()
                        Text("Version 1.1.0")
                            .font(.custom(uiSettings.customFontName, size: 13))
                            .foregroundColor(.white.opacity(0.5))
                        
                            .onTapGesture {
                                tapCount += 1
                                if tapCount == 5 {
                                    tapCount = 0
                                    showTestView = true
                                }
                            }
                        
                    }
                    .padding()
                }
                
                Spacer()
                
                // Bouton de fermeture en bas
                Button(action: {
                    showProfilView = false
                    globalSettings.showTabBar = true

                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                }
                
                
            
        }
                .fullScreenCover(isPresented: $showTestView) {
                    TestView(showTestView: $showTestView)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
    
                
            
          
            
            if showDeleteAccountView {
                
                VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                    .edgesIgnoringSafeArea(.all)
                    
                VStack {
                    Spacer()
                    DeleteAccountView(showDeleteAccountView: $showDeleteAccountView)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedCorners(radius: 50, corners: [.topLeft, .topRight]))
                        .shadow(radius: 10)
                      
                }
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showDeleteAccountView)

            }

            if showLogOutView {
                
                VisualEffectBlur(blurStyle: .systemChromeMaterialDark)
                    .edgesIgnoringSafeArea(.all)
                    
                VStack {
                    Spacer()
                    LogOutView(showLogOutView: $showLogOutView)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedCorners(radius: 50, corners: [.topLeft, .topRight]))
                        .shadow(radius: 10)
                      
                }
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: showLogOutView)
               

            }
        }
    }
}


#Preview {
    ProfilView(showProfilView: .constant(true))
        .background(.black)
}

