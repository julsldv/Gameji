//
//  Bet.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 07/09/2024.
//

import FirebaseFirestore


struct Bet: Identifiable {
    var id: String
    var userId: String
    var marketId: String
    var chosenOption: String
    var stake: Int
    var result: String // "win", "lose", "pending"
    var status: String
    var date: Date
    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.userId = data["userId"] as? String ?? ""
        self.marketId = data["marketId"] as? String ?? ""
        self.chosenOption = data["chosenOption"] as? String ?? ""
        self.stake = data["stake"] as? Int ?? 0
        self.result = data["result"] as? String ?? "pending"
        self.status = data["status"] as? String ?? "ongoing"
        
        // Traiter le champ de date, en utilisant la conversion de Timestamp à Date
        if let timestamp = data["date"] as? Timestamp {
            self.date = timestamp.dateValue()
        } else {
            self.date = Date() // Valeur par défaut si aucune date n'est trouvée
        }
    }
}
