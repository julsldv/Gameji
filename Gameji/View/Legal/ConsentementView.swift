//
//  ConsentementView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct ConsentementView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showConsentementView: Bool
    @Binding var isInApp: Bool

    var body: some View {
        VStack(spacing: 0) {
            if !isInApp {
                HStack {
                    CloseButtonView {
                        print("fermeture termes et conditions")
                        
                    }
                    SpacerRectangle(width: 1, height: 1)
                    VStack {
                        Text("Collecte & utilisation des données")
                            .bold()
                            .font(.system(size: 14, design: .rounded))
                        
                        Text("Dernière mise à jour : 27 Aout 2024")
                            .font(.system(size: 12, design: .rounded))
                    }
                    .foregroundStyle(uiSettings.customFontColor2)
                    Spacer()
                }
                .padding()
            }
            
            ScrollView {
            
            VStack(alignment: .center) {
                    
                    Text("""
                              Consentement à la Collecte et à l'Utilisation des Données sur MyImmoZ
                              
                              En créant un compte sur MyImmoZ, je reconnais et accepte expressément que MyImmoZ collecte et utilise les informations relatives à mon pseudo dans le but de :
                              
                              Améliorer mon expérience d'utilisation de l'application.
                              
                              Je confirme que j'ai l'age minimum requis ou que j'ai obtenu le consentement de mon parent ou tuteur légal si je suis mineur.
                              
                              Je suis informé que je peux retirer ce consentement à tout moment en contactant le service client de MyImmoZ, mais je comprends que cela pourrait affecter ma capacité à utiliser certains services du site.
                              
                              Pour plus d'informations sur la façon dont nous utilisons et protégeons vos informations personnelles, veuillez consulter notre Politique de Confidentialité.
                              
                              En poursuivant mon processus de création de compte, je donne mon consentement explicite à MyImmoZ pour la collecte et l'utilisation de mes données comme décrit ci-dessus.
                              """)
                    .padding()
                    .font(.system(size: 16, design: .rounded))
                    
                }
                
            .foregroundStyle(uiSettings.customFontColor2)
            
                SpacerRectangle(width: 1, height: 10)
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    BackButtonView {
                        print("back from ConsentementView")
                    }
                    
                    SpacerRectangle(width: 1, height: 1)
                    
                    VStack {
                        Text("Collecte & utilisation des données")
                            .bold()
                            .font(.system(size: 14, design: .rounded))
                        
                        Text("Dernière mise à jour : 27 Aout 2024")
                            .font(.system(size: 12, design: .rounded))
                    }
                    .foregroundStyle(uiSettings.customFontColor2)
                }
            })
            
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [uiSettings.customMainColor1, uiSettings.customMainColor2]), startPoint: .topLeading, endPoint: .bottomTrailing
                          )
        )

    }
}

#Preview {
    ConsentementView(showConsentementView: .constant(false), isInApp: .constant(false))
}
