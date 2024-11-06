//
//  ScrollOffsetPreferenceKey.swift
//  Gameji
//
//  Created by Julien PORTOLAN on 31/10/2024.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

