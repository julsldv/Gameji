//
//  WinXpView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 12/09/2024.
//

import SwiftUI

struct WinXpView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    @Binding var showWinXP: Bool
    
    var body: some View {
        
            VStack (alignment: .center) {
                LottieView(filename: "validated")
                    .frame(width: 120, height: 120)
                    .transition(.scale)
                    .background(Color.clear)
                    .padding(.bottom, 5)
                
                
                Text("Houra bien joué 🏆")
                    .font(.system(size: 24, design: .rounded))
                    .foregroundStyle(uiSettings.customFontColor1.opacity(0.9))
                    .bold()
                    .padding(.bottom, 5)
                
                
                Text("Tu empoches \(globalSettings.totalWinningAmount)")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundStyle(uiSettings.customMainColor2)
                    .padding(.bottom, 10)
                
                SpacerRectangle(width: 1, height: 30)
                
                ButtonLargeView(textButton: "Cool") {
                    showWinXP = false
                    globalSettings.xpWin = false // Ré initilisation de l'affichage
                    globalSettings.totalWinningAmount = 0 // Remise à zéro du gain affiché dans l'XP de Win
                    
                }
            }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width * 0.80)
                .padding(25)
                .background(uiSettings.customFontColor2)
                .cornerRadius(15)
                .padding(20)
           
            

   
     
    }
}

#Preview {
    WinXpView(showWinXP: .constant(false))
}


