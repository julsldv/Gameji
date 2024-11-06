//
//  ButtonSmallView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//

import SwiftUI

struct ButtonSmallView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @State private var isButtonMemoPressed = false
    
    var textButton: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action() // Action du bouton envoyé par l'appelant
        }) {
                HStack {
                    Text(textButton)
                }
                .font(.system(size: 18, design: .rounded))
                .padding(10)
                .foregroundColor(uiSettings.customFontColor2)
                .bold()
                .frame(width: 120, height: 55)
                .background(
                    LinearGradient(gradient: Gradient(colors: [uiSettings.customMainColor1, uiSettings.customMainColor2]), startPoint: .topLeading, endPoint: .bottomTrailing
                                  )
                )
                .cornerRadius(15)
            
        }
        .scaleEffect(isButtonMemoPressed ? 0.90 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { inProgress in
            if inProgress {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.5)) {
                    isButtonMemoPressed = true
                }
            } else {
                withAnimation(.easeOut(duration: 0.2)) {
                    isButtonMemoPressed = false
                }
            }
        }) {
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ButtonSmallView(textButton: "Valider", action: {
        print("Action executed")
    })
}
