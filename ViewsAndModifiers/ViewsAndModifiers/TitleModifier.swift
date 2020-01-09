//
//  TitleModifier.swift
//  ViewsAndModifiers
//
//  Created by Samantha Gatt on 1/9/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
