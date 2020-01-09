//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Samantha Gatt on 1/8/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private var backgroundHelloWorld: some View {
        Text("Hello, World!")
            .titleStyle()
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .edgesIgnoringSafeArea(.all)
    }
    private var rainbowText: some View {
        Text("rainbow")
            .padding(10)
            .background(Color.red)
            .padding(10)
            .background(Color.orange)
            .padding(10)
            .background(Color.yellow)
            .padding(10)
            .background(Color.green)
            .padding(10)
            .background(Color.blue)
            .padding(10)
            .background(Color.purple)
            .padding(10)
            .background(Color.black)
    }
    private var capsuleTextStack: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "Hello world")
            CapsuleText(text: "World hello", foregroundColor: .black)
        }
        // String was getting truncated inside text view sometimes
        .frame(maxWidth: .infinity)
    }
    private var environmentModifierStack: some View {
        VStack {
            Text("1")
            Text("2").font(.body)
            Text("3")
        }.font(.title)
    }
    private var buttonWithYellowBackground: some View {
        Button("Hello") {
            // prints `ModifiedContent<ModifiedContent<Text, _FrameLayout>, _BackgroundModifier<Color>>`
            print(type(of: Text("Hello").frame(width: 100, height: 100).background(Color.blue)))
        }.frame(width: 150, height: 150)
            .background(Color.yellow)
    }
    
    var body: some View {
        ZStack {
            backgroundHelloWorld
            VStack(spacing: 20) {
                rainbowText
                capsuleTextStack
                Spacer()
                environmentModifierStack
                buttonWithYellowBackground
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
