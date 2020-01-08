//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Samantha Gatt on 1/7/20.
//  Copyright © 2020 Samantha Gatt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.white, .black]), center: .center, startRadius: 30, endRadius: 300).edgesIgnoringSafeArea(.all)
                Button(action: {
                    print("editing")
                }) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                }
            }
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]), center: .center).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text("woah")
                    Text("there")
                }
            }
            ZStack {
                Color.green.edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    HStack(alignment: .center, spacing: 20) {
                        Text("1")
                        Text("2")
                        Text("3")
                    }
                    HStack(spacing: 20) {
                        Text("4")
                        Text("5")
                        Text("6")
                    }
                    HStack(spacing: 20) {
                        Text("7")
                        Text("8")
                        Text("9")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
