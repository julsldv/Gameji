//
//  SearchView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 04/11/2024.
//

import SwiftUI

// Vue de recherche (à compléter)
struct SearchView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    
    var body: some View {
        VStack (spacing: 0) {
            Text(" ")
                .font(.title)
                .padding()
                .foregroundStyle(Color.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
    }
}


#Preview {
    SearchView()
}
