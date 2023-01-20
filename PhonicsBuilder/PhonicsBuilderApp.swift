import SwiftUI

@main
struct PhonicsBuilderApp: App {
    @StateObject private var globalState = GlobalState()
    @StateObject private var camera = Camera.shared
    @StateObject private var resultsManager = ResultsManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalState)
                .environmentObject(camera)
                .environmentObject(resultsManager)
        }
    }
}
