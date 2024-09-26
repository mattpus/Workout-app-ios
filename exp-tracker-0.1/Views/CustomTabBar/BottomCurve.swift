//
//  BottomCurve.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

struct BottomCurve: Shape {

    var currentXValue: CGFloat
    
    // Animating Path...
    // it wont work on previews....
    var animatableData: CGFloat{
        get{currentXValue}
        set{currentXValue = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // mid will be current XValue..
            let value =
            30.0
            let mid = currentXValue
            path.move(to: CGPoint(x: mid - (value * 2), y: 0))
            
            let to1 = CGPoint(x: mid, y: value)
            let control1 = CGPoint(x: mid - value, y: 0)
            let control2 = CGPoint(x: mid - value, y: value)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: mid + value * 2, y: 0)
            let control3 = CGPoint(x: mid + value, y: value)
            let control4 = CGPoint(x: mid + value, y: 0)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct CustomTabBarShape_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
