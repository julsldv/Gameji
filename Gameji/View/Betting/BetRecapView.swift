//
//  BetRecapView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 10/09/2024.
//

import SwiftUI

struct BetRecapView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared
    
    @Binding var showBetRecap: Bool
    
    var body: some View {
        VStack {
            
                    SpacerRectangle(width: 1, height: 1)
                    
                    LottieView(filename: "fire")
                        .frame(width: 100, height: 100)
                        .transition(.scale)
                        .background(Color.clear)
                        .padding(10)
                    
                   
                    Text("Ton pari est validé 👊")
                        .font(.custom(uiSettings.customFontName, size: 24))
                        .foregroundStyle(uiSettings.customFontColor2)
                        .bold()
                        .padding(20)
                     
                        
                    ButtonLargeView(textButton: "Cool") {
                        showBetRecap = false
                        globalSettings.showTabBar = true
                    }
                    .padding(20)
                }
            .multilineTextAlignment(.center)
            .background(uiSettings.customBackColor1)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(uiSettings.customFontColor2.opacity(0.3), lineWidth: 2)
            )
            .padding(40)
            
           
   

    }
}

#Preview {
    BetRecapView(showBetRecap: .constant(false))
        .background(.black)
}


