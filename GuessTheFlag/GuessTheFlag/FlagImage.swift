//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Samantha Gatt on 1/9/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    var body: some View {
        Image(name).renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 2))
            .shadow(color: .white, radius: 2)
    }
}

