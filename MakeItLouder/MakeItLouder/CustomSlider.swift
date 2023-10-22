//
//  CustomSlider.swift
//  MakeItLouder
//
//  Created by nastasya on 20.10.2023.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var volume: Double
    @State private var startingValue = 0.0
    @State private var scaleWidth = 1.0
    @State private var scaleHeight = 1.0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(width: geometry.size.width * scaleWidth, height: geometry.size.height * scaleHeight)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(.white)
                            .frame(width: geometry.size.width * scaleWidth, height: geometry.size.height * CGFloat(volume) * scaleHeight)
                            .cornerRadius(0)
                    }
            }
            .cornerRadius(geometry.size.width / 3.3)
            .gesture(gesture(geometry: geometry))
            .scaleEffect(x: scaleWidth, y: scaleHeight)
            .offset(y: offset)
        }
    }
    
    func gesture(geometry: GeometryProxy) -> some Gesture {
        LongPressGesture(minimumDuration: 0)
            .onEnded { _ in
                startingValue = volume
            }
            .sequenced(before: DragGesture(minimumDistance: 0)
                .onChanged {
                    self.volume = startingValue - Double(($0.location.y - $0.startLocation.y) / geometry.size.height)
                    if volume > 1 {
                        scaleWidth = 1 / sqrt(volume)
                        scaleHeight = 1 / scaleWidth
                        offset = -geometry.size.height * (scaleHeight - 1)
                        print(scaleHeight)
                    } else if volume < 0{
                        scaleWidth = 1 / sqrt(1 - volume)
                        scaleHeight = 1 / scaleWidth
                        offset = geometry.size.height * (scaleHeight - 1)
                    } else {
                        scaleWidth = 1.0
                        scaleHeight = 1.0
                        offset = 0
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        if volume > 1 {
                            scaleWidth = 1.0
                            scaleHeight = 1.0
                            offset = 0
                            volume = 1
                        } else if volume < 0 {
                            scaleWidth = 1.0
                            scaleHeight = 1.0
                            offset = 0
                            volume = 0
                        }
                    }
                }
            )
    }
}

#Preview {
    ContentView()
}
