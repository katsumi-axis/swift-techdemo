//
//  TimerScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import SwiftUI

public struct TimerScene: View {
    @State private var timeRemaining = 0
    @State private var isTimerRunning = false
    
    public init() {}
    public var body: some View {
        NavigationView {
            VStack {
                Text("\(timeRemaining) seconds")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Button(action: {
                        isTimerRunning.toggle()
                    }) {
                        Text(isTimerRunning ? "Stop" : "Start")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        timeRemaining = 0
                        isTimerRunning = false
                    }) {
                        Text("Reset")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Timer")
        }
    }
}
