//
//  TopView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct TopView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @Binding var showProfilView: Bool
    @Binding var showBetListView: Bool
    @State private var withAnimation = true

    var body: some View {
        HStack {
            Image("betclic")
                .resizable()
                .frame(width: 90, height: 30)

            Spacer()
            FreebetBalanceView()
            
            BalanceView()

            ProfilButtonView(showProfilView: $showProfilView)
            
            MyBetButtonview(showBetListView: $showBetListView)
            
            
        }
        .frame(maxWidth: .infinity)
        .padding(10)
    }
}


#Preview {
    TopView(showProfilView: .constant(false), showBetListView: .constant(false))
        .background(Color.black)
}
