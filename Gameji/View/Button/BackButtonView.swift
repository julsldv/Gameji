//
//  BackButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            
            action() //Les actions demandées par l'appelant
            presentationMode.wrappedValue.dismiss() //Fermer la vue active
            
        }) {
          
            VStack {
                Image(systemName: "chevron.left")
                    .bold()
                    .font(.system(size: 15))
                    .foregroundColor(uiSettings.customFontColor2)
            }
                .frame(height: 25)
                .padding(10)
                .background(uiSettings.customFontColor2.opacity(0.1))
                .cornerRadius(10)

        }
    }
}

#Preview {
    BackButtonView(action: {
        print("Action executed")
    })
    .background(.blue)
}



