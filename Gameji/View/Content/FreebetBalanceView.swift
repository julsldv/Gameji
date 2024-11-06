//
//  FreebetBalanceView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 31/10/2024.
//

import SwiftUI

struct FreebetBalanceView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        HStack(spacing: 8) {
            // "F" inside a red circle with a white border
            ZStack {
                Circle()
                    .fill(uiSettings.customRedColor3) // Red background color
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 1) // White border
                    )
                
                Text("F")
                    .italic()
                    .font(.custom(uiSettings.customFontName, size: 14))
                    .foregroundColor(.white)
                    .bold()
            }
            
            // Displaying balance amount
            Text("\(String(authViewModel.userBalance)) €")
                .font(.custom(uiSettings.customFontName, size: 15))
                .bold()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    FreebetBalanceView()
        .background(Color.black)
}

