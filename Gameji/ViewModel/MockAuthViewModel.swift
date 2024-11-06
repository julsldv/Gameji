//
//  MockAuthViewModel.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 31/10/2024.
//

import SwiftUI


// Mock du AuthViewModel pour les données de prévisualisation
class MockAuthViewModel: AuthViewModel {
    override init() {
        super.init()
        
        // Ajout de marchés fictifs pour la prévisualisation
        markets = [
            Market(id: "1", data: [
                "label": "Match 1",
                "options": ["Option A", "Option B"],
                "correctAnswer": "Option A",
                "status": "ouvert",
                "sport": "Football",
                "competition": "Ligue 1"
            ]),
            Market(id: "2", data: [
                "label": "Match 2",
                "options": ["Option C", "Option D"],
                "correctAnswer": "Option C",
                "status": "ouvert",
                "sport": "Basketball",
                "competition": "NBA"
            ]),
            Market(id: "3", data: [
                "label": "Match 3",
                "options": ["Option E", "Option F"],
                "correctAnswer": "Option F",
                "status": "ouvert",
                "sport": "Tennis",
                "competition": "Wimbledon"
            ])
        ]
    }
}
