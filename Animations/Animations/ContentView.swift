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
    @State private var spinButtonRounded = false
    @State private var dragSize: CGSize = .zero
    @State private var stringDragSize: CGSize = .zero
    @State private var stringViewActive = false
    @State private var selectedLetter = 0
    @State private var hideMeIsShowing = true
    
    // MARK: Properties
    private let letterArray = Array("Hello world")
    private var hideItText: String {
        return hideMeIsShowing ? "Hide it" : "Show it"
    }
    
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
        }.clipShape(Circle())
        .overlay(radarCircle)
        .scaleEffect(buttonScale)
        .blur(radius: (buttonScale - 1) * 3)
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
    private var dragView: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("Drag me")
                .foregroundColor(.white)
        }.offset(dragSize)
        .gesture(
            DragGesture()
                .onChanged { self.dragSize = $0.translation }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        self.dragSize = .zero
                    }
                }
        )
    }
    private var stringDragView: some View {
        HStack(spacing: 0) {
            ForEach(0..<letterArray.count) { i in
                Text(String(self.letterArray[i]))
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(5)
                    .background(self.stringViewActive ? Color.yellow : Color.orange)
                    .offset(self.stringDragSize)
                .animation(
                    Animation.default.delay(self.getDelay(i))
                )
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.stringDragSize = $0.translation
                            self.stringViewActive = true
                            self.selectedLetter = i
                        }
                        .onEnded { _ in
                            self.stringDragSize = .zero
                            self.stringViewActive = false
                        }
                )
            }
        }
    }
    private var hideMeView: some View {
        VStack(spacing: 10) {
            Button(action: {
                withAnimation {
                    self.hideMeIsShowing.toggle()
                }
            }) {
                Text(hideItText)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 30)
                    .background(Color.orange)
            }
            if hideMeIsShowing {
                Text("^^ Hide me ^^")
                    .foregroundColor(.orange)
                    .frame(width: 200, height: 30)
                    .overlay(
                        Rectangle()
                            .stroke(Color.orange, lineWidth: 2)
                    )
                    .transition(.asymmetric(insertion: .pivot, removal: .slide))
            }
        }
    }
    private var spinButton: some View {
        Button(action: {
            self.spinButtonRounded.toggle()
            withAnimation {
                self.rotationAngle += 360
            }
        }) {
            Text("Spin me")
                .padding()
                .foregroundColor(spinButtonRounded ? .black : .white)
                .animation(nil)
                .background(spinButtonRounded ? Color.orange : Color.yellow)
                .animation(.linear)
        }.clipShape(RoundedRectangle(cornerRadius: spinButtonRounded ? 60 : 0))
        .animation(.default)
        .rotation3DEffect(.degrees(rotationAngle),
                          axis: (x: 0, y: 1, z: 0))
    }
    
    // MARK: Content body
    var body: some View {
        VStack {
            Group {
                animationStepper
                Spacer()
            }
            Group {
                animatedButton
                Spacer()
            }
            Group {
                dragView
                Spacer()
            }
            Group {
                stringDragView
                Spacer()
            }
            Group {
                hideMeView
                Spacer()
            }
            Group {
                spinButton
                Spacer()
            }
        }
        .onAppear {
            self.radarScale = 2
        }
    }
    
    // MARK: Methods
    private func getDelay(_ i: Int) -> Double {
        let sDiff = Double(i - selectedLetter)
        let uDiff = sDiff.sign == .minus ? -sDiff : sDiff
        return uDiff / 20
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
