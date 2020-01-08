//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Samantha Gatt on 1/8/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("Hello, World!")
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("rainbow")
                    .padding()
                    .background(Color.red)
                    .padding()
                    .background(Color.orange)
                    .padding()
                    .background(Color.yellow)
                    .padding()
                    .background(Color.green)
                    .padding()
                    .background(Color.blue)
                    .padding()
                    .background(Color.purple)
                    .padding()
                    .background(Color.black)
                Spacer()
                VStack {
                    Text("1")
                    Text("2").font(.body)
                    Text("3")
                }.font(.title)
                Button("Hello") {
                    // prints `ModifiedContent<ModifiedContent<Text, _FrameLayout>, _BackgroundModifier<Color>>`
                    print(type(of: Text("Hello").frame(width: 100, height: 100).background(Color.blue)))
                }.frame(width: 200, height: 200)
                    .background(Color.yellow)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
