//
//  UiSettings.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 06/09/2024.
//

import SwiftUI

class UiSettings: ObservableObject {
    static let shared = UiSettings()
    let customFontName: String = "Avenir-Medium"
    
    //Couleur de font
    @Published var customFontColor1 = Color.black
    @Published var customFontColor2 = Color.white
    @Published var customFontColor3 = Color(red: 0.440, green: 0.440, blue: 0.440)
    @Published var customFontColor4 = Color(red: 0.003, green: 0.003, blue: 0.003)
    @Published var customFontColor5 = Color(red: 0.333, green: 0.361, blue: 0.400)
    
    //Couleur pour les fonds
    @Published var customBackColor1 = Color(red: 0.075, green: 0.078, blue: 0.118)
    @Published var customBackColor2 = Color(red: 0.169, green: 0.180, blue: 0.247)
    @Published var customBackColor3 = Color(red: 0.483, green: 0.749, blue: 0.990)
    @Published var customBackColor4 = Color(red: 0.949, green: 0.949, blue: 0.949)
    @Published var customBackColor5 = Color(red: 0.105, green: 0.152, blue: 0.464)
    @Published var customBlurColor1 = Color(red: 0.214, green: 0.260, blue: 0.268)

    
    //Couleur signature de l'app
    @Published var customMainColor1 = Color(red: 0.246, green: 0.547, blue: 0.937)
    @Published var customMainColor2 = Color(red: 0.403, green: 0.253, blue: 0.941)
    
    @Published var customGreenColor1 = Color(red: 0.451, green: 0.784, blue: 0.573)
    @Published var customGreenColor2 = Color(red: 0.663, green: 0.902, blue: 0.757)
    
    @Published var customOddkColor1 = Color(red: 0.969, green: 0.808, blue: 0.275)
    
    @Published var customRedColor1 = Color(red: 0.651, green: 0.165, blue: 0.161)
    @Published var customRedColor2 = Color(red: 0.757, green: 0.188, blue: 0.165)
    @Published var customRedColor3 = Color(red: 0.808, green: 0.173, blue: 0.149)



}
