//
//  InfoPrivacyView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct InfoPrivacyView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Environment(\.presentationMode) var presentationMode
    @Binding var showInfoPrivacyView: Bool
    @Binding var isInApp: Bool

    var body: some View {
       
        VStack(spacing: 0) {
            if !isInApp {

            HStack {
                CloseButtonView {
                    print("fermeture du de la politique de confidentialité")
                    
                }
                SpacerRectangle(width: 1, height: 1)
                VStack {
                    Text("Politique de Confidentialité de MyImmoZ")
                        .bold()
                        .font(.system(size: 14, design: .rounded))
                    
                    Text("Dernière mise à jour : 27 Aout 2024")
                        .font(.system(size: 12, design: .rounded))
                }
                Spacer()
            }
            .padding()
        }
            
            ScrollView {

                VStack(alignment: .center) {
                    
                    Text("""
                              MyImmoZ, s'engage à protéger votre vie privée. Cette Politique de Confidentialité explique comment nous recueillons, utilisons, divulguons, et protégeons les informations que vous nous fournissez ou que nous recueillons à propos de vous lorsque vous utilisez notre application mobile MyImmoZ ("Application").
                              
                              ## 1. Informations que nous recueillons
                              
                              Nous recueillons les informations suivantes vous concernant :
                              
                              - **Informations fournies par l'utilisateur** : Cela inclut le pseudo et l'adresse e-mail.
                              
                              ## 2. Comment nous utilisons vos informations
                              
                              Vos informations sont utilisées pour :
                              
                              - Fournir, opérer, et maintenir notre application.
                              - Améliorer, personnaliser, et étendre notre application.
                              - Comprendre et analyser comment vous utilisez notre application.
                              - Développer de nouveaux produits, services, fonctionnalités, et fonctionnalités.
                              - Communiquer avec vous, directement ou par l'un de nos partenaires, y compris pour le service client, pour vous fournir des mises à jour et d'autres informations relatives à l'application, et à des fins de marketing et de promotion.
                              - Vous envoyer des e-mails.
                              - Trouver et prévenir la fraude.
                              
                              ## 3. Partage de vos informations
                              
                              Nous ne partageons vos informations personnelles avec des tiers que dans les cas suivants :
                              
                              - Consentement : Nous partagerons les informations personnelles avec des tiers lorsque nous aurons votre consentement à le faire.
                              - Fournisseurs de services : Nous pouvons partager vos informations personnelles avec des fournisseurs de services qui réalisent des services pour nous.
                              - Conformité légale : Nous partagerons les informations personnelles lorsque nous serons légalement tenus de le faire.
                              
                              ## 4. Sécurité
                              
                              Nous nous efforçons de protéger votre information personnelle en utilisant des mesures de sécurité appropriées.
                              
                              ## 5. Vos droits
                              
                              Vous avez le droit de demander l'accès, la correction ou la suppression de vos informations personnelles. Vous pouvez également demander la limitation du traitement de vos informations personnelles, dans certaines circonstances.
                              
                              ## 6. Modifications de cette Politique de Confidentialité
                              
                              Nous pouvons mettre à jour notre Politique de Confidentialité de temps à autre. Nous vous notifierons de tout changement en publiant la nouvelle Politique de Confidentialité sur cette page.
                              
                              ## 7. Nous contacter
                              
                              Si vous avez des questions sur cette Politique de Confidentialité, veuillez nous contacter.
                              """)
                    .padding()
                    .font(.system(size: 16, design: .rounded))
                    
                }
                SpacerRectangle(width: 1, height: 10)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    BackButtonView {
                        print("back from InfoPrivacyView")
                    }
                    SpacerRectangle(width: 1, height: 1)
                    
                    VStack {
                        Text("Politique de Confidentialité de MyImmoZ")
                            .bold()
                            .font(.system(size: 14, design: .rounded))
                        
                        Text("Dernière mise à jour : 27 Aout 2024")
                            .font(.system(size: 12, design: .rounded))
                    }
                    .foregroundStyle(uiSettings.customFontColor2)
                }
            })
        }
        .padding(10)
        .foregroundStyle(uiSettings.customFontColor2)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [uiSettings.customMainColor1, uiSettings.customMainColor2]), startPoint: .topLeading, endPoint: .bottomTrailing
                          )
        )

    }
}

#Preview {
    InfoPrivacyView(showInfoPrivacyView: .constant(false), isInApp: .constant(false))
}
