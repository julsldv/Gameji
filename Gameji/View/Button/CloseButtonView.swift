//
//  CloseButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    @State private var isLoading = false
    
    var action: () -> Void
    
    var body: some View {
        
        Button(action: {
            
            action() //Les actions demandées par l'appelant
            HapticManager.triggerLightImpact() //La vibration
            presentationMode.wrappedValue.dismiss() //Fermer la vue active
            
        }) {
                VStack {
                    Image(systemName: "chevron.down")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(uiSettings.customFontColor2)
                }
                .frame(height: 25)
                .padding(10)
            }
    }
}

#Preview {
    CloseButtonView(action: {
        print("Action executed")
    })
}




