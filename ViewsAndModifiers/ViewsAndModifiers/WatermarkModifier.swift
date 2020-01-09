//
//  WatermarkModifier.swift
//  ViewsAndModifiers
//
//  Created by Samantha Gatt on 1/9/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
