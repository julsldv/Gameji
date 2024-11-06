//
//  CloseModalButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct CloseModalButtonView: View {
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
                .padding()
                .foregroundColor(Color.white)
                .bold()
                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .cornerRadius(15)
            
        }
        .frame(height: 25)
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
    CloseModalButtonView(textButton: "Faire une action", action: {
        print("Action executed")
    })
}
