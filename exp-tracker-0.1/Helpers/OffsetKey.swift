//
//  OffsetKey.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

