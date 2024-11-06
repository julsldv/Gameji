//
//  GlobalSettings.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

class GlobalSettings: ObservableObject {
    
static let shared = GlobalSettings()

    @Published var xpWin: Bool = false
    @Published var showTabBar: Bool = true
    @Published var totalWinningAmount = 0
    
}
