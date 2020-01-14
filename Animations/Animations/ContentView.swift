//
//  ContentView.swift
//  Animations
//
//  Created by Samantha Gatt on 1/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var buttonScale: CGFloat = 1.0
    
    var body: some View {
        Button("Tap me") {
            self.buttonScale += 1.0
        }.padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(buttonScale)
        .blur(radius: (buttonScale - 1) * 3)
        .animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
