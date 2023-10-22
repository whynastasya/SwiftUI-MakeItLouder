//
//  ContentView.swift
//  MakeItLouder
//
//  Created by nastasya on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 0.7
    var body: some View {
        ZStack (alignment: .center) {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 3)
            CustomSlider(volume: $value)
                .frame(width: 100, height: 250)
        }
    }
}

#Preview {
    ContentView()
}
