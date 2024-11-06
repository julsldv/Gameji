//
//  LottieView.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 10/09/2024.
//


import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var filename: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear // S'assurer que la vue parent est transparente

        // Initialiser l'AnimationView avec le fichier JSON de l'animation
        let animationView = LottieAnimationView(name: filename) // Utilisez 'LottieAnimationView' au lieu de 'AnimationView'
        animationView.backgroundColor = .clear // S'assurer que l'AnimationView est transparent
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop // Optionnel : Répète l'animation
        animationView.play()
        animationView.animationSpeed = 2
        
        // Ajouter l'AnimationView à la vue parent
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        // Configurer les contraintes pour que l'AnimationView occupe toute la vue parent
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Mettre à jour la vue si nécessaire
    }
}
