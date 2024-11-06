//
//  FirebaseManager.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//


import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    var auth: Auth
    var cloudFirestore: Firestore
    
    init() {
        FirebaseApp.configure()
        auth = Auth.auth()
        cloudFirestore = Firestore.firestore()
    }
    
    var usersRef: CollectionReference {
        return cloudFirestore.collection(USERS)
    }
    
    var marketsRef: CollectionReference {
            return cloudFirestore.collection("Markets")
        }
    
    var betsRef: CollectionReference {
           return cloudFirestore.collection("Bets")
       }
    
    func userDoc(_ id: String) -> DocumentReference {
        return usersRef.document(id)
    }
    
    func marketDoc(_ id: String) -> DocumentReference {
            return marketsRef.document(id)
        }
    
    func betDoc(_ id: String) -> DocumentReference {
           return betsRef.document(id)
       }
    
    func logOut() {
        do {
            try auth.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createUserForFirestore(uid: String, datas: [String: Any]) {
        let document = usersRef.document(uid)
        document.setData(datas)
    }
    
}
