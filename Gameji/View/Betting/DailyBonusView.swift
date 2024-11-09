//
//  DailyBonusView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 13/09/2024.
//

import SwiftUI

struct DailyBonusView: View {
    @ObservedObject var uiSettings = UiSettings.shared

    @Binding var showDailyBonusModal: Bool
    var onCredit: () -> Void

    var body: some View {
            
      
                VStack(alignment: .center) {
                    
                    SpacerRectangle(width: 1, height: 1)
                    
                    Text("🙌")
                        .font(.system(size: 70))
                        .padding(.bottom, 5)
                    
                    Text("Boost")
                        .font(.custom(uiSettings.customFontName, size: 28))
                        .foregroundStyle(uiSettings.customFontColor2)
                        .bold()
                        .padding(.bottom, 5)
                    
                    Text("Tous les jours + 100€ sur ton compte")
                        .font(.custom(uiSettings.customFontName, size: 22))
                        .foregroundStyle(uiSettings.customFontColor2)
                        .padding(.bottom, 10)
                    
                    
                    ButtonLargeView(textButton: "Ok merci !") {
                        onCredit()
                        playHapticLoop()
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
                .padding(20)

            
        }
      
    }
    
    // Fonction pour jouer le haptique avec deux séquences
    func playHapticLoop() {
        // Première séquence: 40 vibrations légères rapprochées
        for i in 0..<80 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.01) {
                HapticManager.triggerLightImpact()
            }
        }
        
        // Calculer le délai de début pour la seconde séquence
        let delayForSecondSequence = Double(80) * 0.01 // Temps total de la première séquence

        // Deuxième séquence: vibration légère-lourde-légère avec un intervalle plus long
        let intervals: [Double] = [0.5, 0.9, 1.2] // Intervalles plus longs entre chaque vibration
        let hapticTypes: [() -> Void] = [
            { HapticManager.triggerLightImpact() }, // Light
            { HapticManager.triggerHeavyImpact() }, // Heavy
            { HapticManager.triggerLightImpact() }  // Light
        ]

        // Déclencher chaque vibration de la seconde séquence avec les intervalles plus longs
        for (index, interval) in intervals.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayForSecondSequence + interval) {
                hapticTypes[index]()
            }
        }
    }

    
    


#Preview {
    DailyBonusView(showDailyBonusModal: .constant(true), onCredit: {})
        .background(.black)

}
