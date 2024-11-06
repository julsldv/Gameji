//
//  ErrorPlacementView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 08/09/2024.
//

import SwiftUI

struct ErrorPlacementView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Binding var errorMessage: String
    @Binding var showModalError: Bool
    
    var body: some View {
        

        VStack {
            VStack (alignment: .center) {
                Text(errorMessage)
                    .font(.headline)
                SpacerRectangle(width: 1, height: 5)
                ButtonLargeView(textButton: "Compris !") {
                    showModalError = false
                }
            }
            .frame(maxWidth: .infinity)
            .frame(width: UIScreen.main.bounds.width * 0.80)
            .padding(25)
        }
        .background(uiSettings.customFontColor2)
        .cornerRadius(15)
        .padding(20)

    }
}

#Preview {
    ErrorPlacementView(errorMessage: .constant("message d'erreur"), showModalError: .constant(false))
}


