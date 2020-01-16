//
//  CornerRotationModifier.swift
//  Animations
//
//  Created by Samantha Gatt on 1/16/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct CornerRotationModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotationModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotationModifier(amount: 0, anchor: .topLeading)
        )
    }
}
