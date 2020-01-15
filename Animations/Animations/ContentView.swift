//
//  ContentView.swift
//  Animations
//
//  Created by Samantha Gatt on 1/14/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: State variables
    @State private var buttonScale: CGFloat = 1.0
    @State private var radarScale: CGFloat = 1.0
    @State private var rotationAngle = 0.0
    
    // MARK: Subviews
    private var radarCircle: some View {
        Circle()
            .stroke(Color.red)
            // starts at 1 then increases to 2 onAppear
            .scaleEffect(radarScale)
            // opacity starts at 1 then decreases to 0 onAppear
            .opacity(Double(2 - radarScale))
            .animation(
                Animation.easeOut(duration: 1)
                    .repeatForever(autoreverses: false)
            )
    }
    private var animatedButton: some View {
        Button(action: {
            self.buttonScale += 1.0
        }) {
            Text("Tap me")
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(radarCircle)
                .scaleEffect(buttonScale)
                .blur(radius: (buttonScale - 1) * 3)
        }
    }
    private var animationStepper: some View {
        Stepper("Scale amount",
                value: $buttonScale.animation(
                    Animation.interpolatingSpring(stiffness: 30, damping: 4)
                        .delay(0.5)
                        .repeatCount(3, autoreverses: true)
                    ),
                in: 0.5...10,
                step: 0.5)
            .padding()
    }
    private var spinButton: some View {
        Button(action: {
            withAnimation {
                self.rotationAngle += 360
            }
        }) {
            Text("Spin me")
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
        }.rotation3DEffect(.degrees(rotationAngle),
                           axis: (x: 0, y: 1, z: 0))
    }
    
    // MARK: Content body
    var body: some View {
        VStack {
            animationStepper
            Spacer()
            animatedButton
            Spacer()
            spinButton
            Spacer()
        }
        .onAppear {
            self.radarScale = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
