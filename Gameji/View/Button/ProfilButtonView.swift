//
//  ProfilButtonView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct ProfilButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var uiSettings = UiSettings.shared
    @ObservedObject var globalSettings = GlobalSettings.shared

    @Binding var showProfilView: Bool

    var body: some View {
        VStack {
            Button(action: {
                showProfilView = true
                globalSettings.showTabBar = false
            }) {
                    Image("account")

            }
        }
    }
}


#Preview {
    ProfilButtonView(showProfilView: .constant(false))
}
