//
//  AppFeature.swift
//  Internal
//
//  Created by katsumi on 2024/11/24.
//

import ComposableArchitecture
import GitHubSearchScene
import SwiftUI
import TimerScene
import TodoScene

public struct AppFeature: View {
    public init() {}
    public var body: some View {
        TabView {
            TimerScene(
                store: Store(
                    initialState: TimerReducer.State(),
                    reducer: { TimerReducer() }
                )
            )
            .tabItem {
                Image(systemName: "timer")
                Text("Timer")
            }

            TodoScene(store: .init(initialState: TodoSceneReducer.State(), reducer: { TodoSceneReducer() }))
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Todo")
                }
            GitHubSearchScene(store: .init(initialState: GitHubSearchReducer.State(), reducer: { GitHubSearchReducer() }))
                .tabItem {
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                    Text("GitHub")
                }
        }
    }
}

struct AppFeature_Previews: PreviewProvider {
    static var previews: some View {
        AppFeature()
    }
}
