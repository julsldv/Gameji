//
//  Market.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//

import Foundation

struct Market: Identifiable {
    var id: String
    var label: String
    var options: [String]
    var correctAnswer: String
    var status: String
    var sport: String
    var competition: String
    var special: Bool


    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.label = data["label"] as? String ?? ""
        self.options = data["options"] as? [String] ?? []
        self.correctAnswer = data["correctAnswer"] as? String ?? ""
        self.status = data["status"] as? String ?? "fermé"
        self.sport = data["sport"] as? String ?? "football"
        self.competition = data["competition"] as? String ?? "Ligue 1"
        self.special = data["special"] as? Bool ?? false
    }
}
