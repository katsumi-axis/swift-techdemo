//
//  TimerSceneTest.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import ComposableArchitecture
import TimerScene
import XCTest

@testable import TimerScene

@MainActor
final class TimerReducerTests: XCTestCase {
    func testTimerBasicFlow() async {
        let clock = TestClock()

        let store = TestStore(initialState: TimerReducer.State()) {
            TimerReducer()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }

        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
}
