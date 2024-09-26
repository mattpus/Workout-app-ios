//
//  AnimatedText.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

struct AnimatedNumberText: Animatable,View {
    var value: CGFloat
    // Optional Properties
    var font: Font
    var floatingPoint: Int = 2
    var isCurrency: Bool = false
    var additionalString: String = ""
    
    var animatableData: CGFloat{
        get{value}
        set{value = newValue}
    }
    var body: some View {
        Text("\(isCurrency ? "$" : "")\(String(format: "%.\(floatingPoint)f", value))" + additionalString)
            .font(font)
    }
}
