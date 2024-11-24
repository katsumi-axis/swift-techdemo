//
//  TimerScene.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
public struct TimerReducer: Reducer, Sendable {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init(count: Int = 0, isTimerRunning: Bool = false) {
            self.count = count
            self.isTimerRunning = isTimerRunning
        }
        var count = 0
        var isTimerRunning = false
    }

    public enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
        case timerTick
        case toggleTimerButtonTapped
    }
    public enum CancelID: Sendable { case timer }

    @Dependency(\.continuousClock) var clock

    public func reduce(into state: inout State, action: Action) -> Effect<
        Action
    > {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        case .timerTick:
            state.count += 1
            return .none
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {
                return .run { send in
                    for await _ in self.clock.timer(interval: .seconds(1)) {
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        }
    }
}

public struct TimerScene: View {
    public init(store: StoreOf<TimerReducer>) {
        self.store = store
    }
    let store: StoreOf<TimerReducer>

    public var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            HStack {
                Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                    store.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    TimerScene(
        store: .init(
            initialState: TimerReducer.State(),
            reducer: { TimerReducer() }
        )
    )
}
