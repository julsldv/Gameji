//
//  BalanceView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct BalanceView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                // Action for adding to balance can be implemented here
            }) {
                HStack {
                    Image(systemName: "plus")
                        .font(.custom(uiSettings.customFontName, size: 14))
                        .foregroundColor(uiSettings.customRedColor3)
                        .bold()
                        .frame(width: 15, height: 15)
                        .background(Color.white)
                        .clipShape(Circle())
                      

                    Text("\(String(authViewModel.userBalance)) €")
                        .font(.custom(uiSettings.customFontName, size: 15))
                        .bold()
                        .foregroundColor(uiSettings.customFontColor2)
                        
                       
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 5)
                .background(uiSettings.customRedColor3)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
              
            }

           
        }
    }
}

#Preview {
    BalanceView()
        .background(Color.blue)
}

