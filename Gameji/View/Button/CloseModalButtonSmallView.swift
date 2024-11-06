//
//  CloseModalButtonSmallView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//

import SwiftUI

struct CloseModalButtonSmallView: View {
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
                .foregroundColor(uiSettings.customMainColor2)
                .bold()
                .frame(width: 120, height: 55)
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
    CloseModalButtonSmallView(textButton: "Faire une action", action: {
        print("Action executed")
    })
}
