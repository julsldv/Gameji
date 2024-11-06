//
//  AuthViewModel.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    var manager = FirebaseManager.shared
 
    @ObservedObject var globalSettings = GlobalSettings.shared
    @Published var isFinishedConnecting: Bool = false
    @Published var isAuth: Bool = false
    @Published var showError: Bool = false
    @Published var userEmail: String = ""
    @Published var userPseudo: String = ""
    @Published var userBalance: Int = 0
    @Published var markets: [Market] = []
    @Published var bets: [Bet] = []
    @Published var showDailyBonusModal: Bool = false
    @Published var ongoingBetsCount: Int = 0
    
    var errorString: String = ""
    var datas: [String: Any] = [:]
    var auth: Auth {
        return manager.auth
    }
    
    init() {
        observeAuthentication()
        fetchMarkets()
        observeOngoingBets()
    }
    
    // Observer l'Authentication et le User
    func observeAuthentication() {
        auth.addStateDidChangeListener(handleChangeListener)
    }
    
    private func observeUserChanges(uid: String) {
        manager.userDoc(uid).addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Erreur lors de l'écoute des changements de l'utilisateur : \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot, document.exists else {
                print("Le document de l'utilisateur n'existe pas.")
                return
            }

            // Mettre à jour les données locales lorsqu'un changement est détecté
            self.userPseudo = document.data()?["Pseudo"] as? String ?? "Pseudo inconnu"
            self.userBalance = document.data()?["Balance"] as? Int ?? 0
            
            // Vérifier le bonus quotidien
            self.checkDailyBonus(uid: uid)
        }
    }

    func handleChangeListener(auth: Auth, user: User?) {
        self.isFinishedConnecting = true
        self.isAuth = user != nil
        if let user = user {
            self.userEmail = user.email ?? ""
            observeUserChanges(uid: user.uid)
        }
    }
    
    func observeOngoingBets() {
           guard let uid = auth.currentUser?.uid else { return }
           manager.betsRef.whereField("userId", isEqualTo: uid).whereField("status", isEqualTo: "ongoing")
               .addSnapshotListener { [weak self] querySnapshot, error in
                   if let error = error {
                       print("Erreur lors de l'écoute des paris en cours : \(error.localizedDescription)")
                       return
                   }
                   
                   self?.ongoingBetsCount = querySnapshot?.documents.count ?? 0
               }
       }
   

    private func checkDailyBonus(uid: String) {
           manager.userDoc(uid).getDocument { [weak self] documentSnapshot, error in
               guard let self = self else { return }
               if let error = error {
                   print("Erreur lors de la récupération de l'utilisateur : \(error.localizedDescription)")
                   return
               }

               guard let document = documentSnapshot, document.exists else {
                   print("Le document de l'utilisateur n'existe pas.")
                   return
               }

               let lastCreditDate = document.data()?["lastCreditDate"] as? Timestamp
               let today = Calendar.current.startOfDay(for: Date())
               let lastCredit = lastCreditDate?.dateValue() ?? Date.distantPast

               // Si la date du dernier crédit est antérieure à aujourd'hui, montrer le modal
               if Calendar.current.isDate(lastCredit, inSameDayAs: today) == false {
                   SwiftUI.withAnimation {
                       self.showDailyBonusModal = true
                   }
               }
           }
       }

    func creditDailyBonus() {
        guard let uid = auth.currentUser?.uid else { return }
        
        let newBalance = self.userBalance + 100
        let today = Date()

        manager.userDoc(uid).updateData([
            "Balance": newBalance,
            "lastCreditDate": Timestamp(date: today)
        ]) { [weak self] error in
            if let error = error {
                print("Erreur lors du crédit quotidien : \(error.localizedDescription)")
            } else {
                self?.userBalance = newBalance
                self?.showDailyBonusModal = false
            }
        }
    }
   
    
    private func fetchUserData(uid: String) {
          manager.userDoc(uid).getDocument { document, error in
              if let document = document, document.exists {
                  self.userPseudo = document.data()?["Pseudo"] as? String ?? "Pseudo inconnu"
                  self.userBalance = document.data()?["Balance"] as? Int ?? 0
              } else {
                  print("Le document de l'utilisateur n'existe pas ou il y a une erreur.")
              }
          }
      }
    
    func fetchMarkets() {
        manager.marketsRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Erreur lors de la récupération des markets : \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("Aucun market trouvé.")
                return
            }

            self.markets = documents.map { Market(id: $0.documentID, data: $0.data()) }

            // Pour chaque marché fermé, appeler handleMarketClosure
            for market in self.markets where market.status == "fermé" {
                self.handleMarketClosure(market: market)
            }
        }
    }

    func placeBet(market: Market, chosenOption: String, stake: Int, completion: @escaping (Bool, String?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            print("Utilisateur non connecté.")
            completion(false, "Utilisateur non connecté.")
            return
        }
        
        manager.userDoc(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Erreur lors de la récupération de la balance utilisateur : \(error.localizedDescription)")
                completion(false, "Erreur lors de la récupération de la balance utilisateur : \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists, let userData = document.data() else {
                print("Impossible de récupérer les données de l'utilisateur.")
                completion(false, "Impossible de récupérer les données de l'utilisateur.")
                return
            }
            
            let currentBalance = userData["Balance"] as? Int ?? 0
            
            if currentBalance >= stake {
                // Inclure la date de création du pari
                let betData: [String: Any] = [
                    "userId": uid,
                    "marketId": market.id,
                    "chosenOption": chosenOption,
                    "stake": stake,
                    "result": "pending",
                    "status": "ongoing",
                    "date": Timestamp(date: Date()) // Utiliser Timestamp pour enregistrer la date actuelle
                ]
                
                manager.betsRef.addDocument(data: betData) { [weak self] error in
                    guard let self = self else { return }
                    if let error = error {
                        print("Erreur lors de la création du pari : \(error.localizedDescription)")
                        completion(false, "Erreur lors de la création du pari : \(error.localizedDescription)")
                    } else {
                        self.userBalance -= stake
                        self.manager.userDoc(uid).updateData(["Balance": self.userBalance]) { error in
                            if let error = error {
                                print("Erreur lors de la mise à jour de la balance : \(error.localizedDescription)")
                                completion(false, "Erreur lors de la mise à jour de la balance : \(error.localizedDescription)")
                            } else {
                                print("Pari placé avec succès.")
                                completion(true, nil)
                            }
                        }
                    }
                }
            } else {
                print("Vous n'avez pas assez de Freecoin pour placer ce pari ! Vous avez \(currentBalance) mais le montant du pari est de \(stake).")
                completion(false, "Tu n'as pas assez de Freecoins pour placer ce pari.")
            }
        }
    }

    func handleMarketClosure(market: Market) {
        manager.betsRef.whereField("marketId", isEqualTo: market.id).whereField("status", isEqualTo: "ongoing").getDocuments { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Erreur lors de la récupération des paris : \(error.localizedDescription)")
                return
            }
            
            var hasWinningBet = false // Indicateur pour savoir s'il y a un pari gagnant
            var totalWinningAmount = 0 // Variable pour accumuler le montant total des gains
            
            for document in querySnapshot?.documents ?? [] {
                let data = document.data()
                let userId = data["userId"] as? String ?? ""
                let chosenOption = data["chosenOption"] as? String ?? ""
                let stake = data["stake"] as? Int ?? 0
                var result = "lost"
                
                if chosenOption == market.correctAnswer {
                    result = "won"
                    hasWinningBet = true // Marque qu'il y a au moins un pari gagnant
                    totalWinningAmount += stake // Ajouter le montant du gain au total
                    
                    // Commencez une transaction pour mettre à jour la balance atomiquement et de manière sécurisée
                    self.manager.cloudFirestore.runTransaction({ (transaction, errorPointer) -> Any? in
                        let userRef = self.manager.userDoc(userId)
                        let betRef = document.reference
                        
                        let userSnapshot: DocumentSnapshot
                        let betSnapshot: DocumentSnapshot
                        
                        do {
                            try userSnapshot = transaction.getDocument(userRef)
                            try betSnapshot = transaction.getDocument(betRef)
                        } catch let fetchError as NSError {
                            errorPointer?.pointee = fetchError
                            return nil
                        }
                        
                        // Vérifiez le statut actuel du pari pour éviter la double mise à jour
                        let currentStatus = betSnapshot.data()?["status"] as? String ?? "ongoing"
                        if currentStatus != "ongoing" {
                            return nil // Si le pari est déjà traité, ne faites rien
                        }
                        
                        let currentBalance = userSnapshot.data()?["Balance"] as? Int ?? 0
                        let newBalance = currentBalance + stake
                        
                        // Met à jour la balance de l'utilisateur
                        transaction.updateData(["Balance": newBalance], forDocument: userRef)
                        // Marquez le pari comme traité
                        transaction.updateData(["result": result, "status": "ended"], forDocument: betRef)
                        
                        return nil
                    }) { (object, error) in
                        if let error = error {
                            print("Erreur lors de la transaction de mise à jour de la balance : \(error.localizedDescription)")
                        } else {
                            print("Balance et pari mis à jour avec succès.")
                        }
                    }
                } else {
                    // Mettre à jour le pari perdu sans transaction
                    document.reference.updateData(["result": result, "status": "ended"]) { error in
                        if let error = error {
                            print("Erreur lors de la mise à jour du pari : \(error.localizedDescription)")
                        } else {
                            print("Pari mis à jour avec succès et statut passé à ended.")
                        }
                    }
                }
            }

            // Après avoir traité tous les paris, vérifiez s'il y a eu un pari gagnant
            if hasWinningBet {
                globalSettings.xpWin = true // Déclencher la fenêtre de gain
                globalSettings.totalWinningAmount = totalWinningAmount // Enregistrer le montant total des gains
            }
        }
    }



    // Connexion de l'utilisateur
    func signIn(email: String, password: String) {
        guard checkValue(email, value: "adresse mail") else { return }
        guard checkValue(password, value: "mot de passe") else { return }
        auth.signIn(withEmail: email, password: password, completion: completionAuth)
    }
    
    // Création de l'utilisateur
    func createUser(
        email: String,
        password: String,
        pseudo: String,
        balance: String
    ) {
        guard checkValue(pseudo, value: "pseudo") else { return }
        guard checkValue(email, value: "adresse mail") else { return }
        guard checkValue(password, value: "mot de passe") else { return }
        guard checkValue(balance, value: "balance") else { return }

        datas = [
            PSEUDO: pseudo,
            EMAIL: email,
            BALANCE: balance,
        ]

        auth.createUser(withEmail: email, password: password, completion: completionAuth)
    }

    // Gestion du résultat de l'authentification
    func completionAuth(result: AuthDataResult?, error: Error?) {
        if let error = error {
            self.errorString = error.localizedDescription
            self.showError = true
            return
        }
        if let data = result {
            let user = data.user
            let uid = user.uid
            if !datas.isEmpty {
                manager.createUserForFirestore(uid: uid, datas: datas)
                datas = [:]
            }
        }
    }
    
    // Vérification des valeurs
    func checkValue(_ string: String, value: String) -> Bool {
        let isNotEmpty = string != ""
        self.errorString = isNotEmpty ? "" : "Merci d'entrer \(value) pour continuer"
        self.showError = !isNotEmpty
        return isNotEmpty
    }
    
    // Fonction de suppression de compte utilisateur
    func deleteUserAccount(completion: @escaping (Bool, String) -> Void) {
        guard let user = auth.currentUser else {
            completion(false, "Aucun utilisateur connecté.")
            return
        }
        
        // Supprimer les données utilisateur de Firestore
        manager.userDoc(user.uid).delete { error in
            if let error = error {
                completion(false, "Erreur lors de la suppression des données de l'utilisateur : \(error.localizedDescription)")
                return
            }
            
            // Supprimer le compte utilisateur de Firebase Auth
            user.delete { [weak self] error in
                if let error = error {
                    completion(false, "Erreur lors de la suppression du compte utilisateur : \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self?.isAuth = false // Mettre à jour l'état d'authentification
                    }
                    completion(true, "Compte utilisateur supprimé avec succès.")
                }
            }
        }
    }
    
    
    func updateBalances(balance: Int) {
          guard let uid = auth.currentUser?.uid else { return }
          
          let data = [
              "Balance": balance,
          ]
          
          manager.userDoc(uid).updateData(data) { error in
              if let error = error {
                  print("Erreur lors de la mise à jour des balances : \(error.localizedDescription)")
              } else {
                  self.userBalance = balance
                  print("Les balances ont été mises à jour avec succès.")
              }
          }
      }
    
    
}


