//
//  MyBetButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 08/09/2024.
//

import SwiftUI

struct MyBetButtonview: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    @ObservedObject var authViewModel = AuthViewModel() // Utiliser l'instance d'AuthViewModel
    @Binding var showBetListView: Bool

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Button(action: {
                    showBetListView = true
                    globalSettings.showTabBar = false
                }) {
                        Image("mybet")
                
                }
                
                if authViewModel.ongoingBetsCount > 0 {
                    Text("\(authViewModel.ongoingBetsCount)")
                        .font(.system(size: 10))
                        .padding(6)
                        .background(Color.white)
                        .clipShape(Circle())
                        .foregroundColor(uiSettings.customFontColor1)
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
}


struct MyBetButtonview_Previews: PreviewProvider {
    static var previews: some View {
        MyBetButtonview(showBetListView: .constant(false))
            .environmentObject(UiSettings.shared)
            .environmentObject(AuthViewModel())
    }
}


