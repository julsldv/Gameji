//
//  ImageSelector.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 04/11/2024.
//

import Foundation

struct ImageSelector {
    // Liste des images disponibles
    private static let images = [
        "basket1", "basket2", "basket3", "basket4",
        "foot1", "foot2", "foot3", "foot4", "foot5", "foot6", "foot7", "foot8", "foot9", "foot10",
        "tennis1", "tennis2",
        "rugby1", "rugby2", "rugby3",
        "usfoot1", "usfoot2",
        "natation1",
        "formule1"
    ]
    
    // Dictionnaire pour les préfixes des sports
    private static let sportPrefixes: [String: String] = [
        "football": "foot",
        "tennis": "tennis",
        "basket": "basket",
        "rugby": "rugby",
        "foot us": "usfoot",
        "natation": "natation",
        "formule 1": "formule1"
    ]
    
    // Fonction pour sélectionner une image aléatoire en fonction du sport
    static func selectImage(for sport: String) -> String {
        let prefix = sportPrefixes[sport.lowercased()] ?? ""
        let filteredImages = images.filter { $0.hasPrefix(prefix) }
        return filteredImages.randomElement() ?? "defaultImageName"
    }
}
