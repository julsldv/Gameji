//
//  IntroView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

struct IntroView: View {
    @ObservedObject var uiSettings = UiSettings.shared
    @State private var animateCircle1 = false
    @State private var animateCircle2 = false
    @State private var animateCircle3 = false
    @State private var imageOpacity = 0.0 // Ajout d'un état pour l'opacité de l'image

    var body: some View {
        VStack(spacing: 5) {
            
            SpacerRectangle(width: 1, height: 120)
       
            
            HStack(spacing: 15) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    .offset(y: animateCircle1 ? -20 : 0)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.0),
                        value: animateCircle1
                    )
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    .offset(y: animateCircle2 ? -20 : 0)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.3),
                        value: animateCircle2
                    )
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    .offset(y: animateCircle3 ? -20 : 0)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.6),
                        value: animateCircle3
                    )
            }
            .onAppear {
                animateCircles()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("bg2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }

    func animateCircles() {
        animateCircle1 = true
        animateCircle2 = true
        animateCircle3 = true
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(uiSettings: UiSettings.shared)
    }
}
