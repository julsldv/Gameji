//
//  CloseBetButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 09/09/2024.
//

import SwiftUI

struct CloseBetButtonView: View {
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
                    Image(systemName: "xmark")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor(uiSettings.customFontColor2)
                
            }
    }
}

#Preview {
    CloseBetButtonView(action: {
        print("Action executed")
    })
}
