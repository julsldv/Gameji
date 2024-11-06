//
//  ButtonLargeView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct ButtonLargeView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @State private var isButtonPressed = false
    
    var textButton: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action() // Action du bouton envoyé par l'appelant
        }) {
                HStack {
                    Text(textButton)
                }
                .font(.custom(uiSettings.customFontName, size: 18))
                .padding()
                .foregroundColor(uiSettings.customFontColor2)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 55)
                .background(uiSettings.customRedColor3)
             
                .cornerRadius(10)
            
        }
        .scaleEffect(isButtonPressed ? 0.90 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { inProgress in
            if inProgress {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.5)) {
                    isButtonPressed = true
                }
            } else {
                withAnimation(.easeOut(duration: 0.2)) {
                    isButtonPressed = false
                }
            }
        })
        {
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ButtonLargeView(textButton: "Faire une action", action: {
        print("Action executed")
    })
}
