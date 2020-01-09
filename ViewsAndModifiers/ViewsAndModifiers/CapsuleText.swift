//
//  CapsuleText.swift
//  ViewsAndModifiers
//
//  Created by Samantha Gatt on 1/8/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    var font: Font = .title
    var foregroundColor: Color = .white
    var background: some View = Color.blue
    var body: some View {
        Text(text)
            .font(font)
            .padding()
            .foregroundColor(foregroundColor)
            .background(background)
            .clipShape(Capsule())
    }
}
