import SwiftUI
import AVFoundation

@main
struct PhonicsBuilderApp: App {
    @StateObject private var resultsManager = ResultsManager.shared
    @StateObject private var camera = Camera.shared
    @StateObject private var globalState = GlobalState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(camera)
                .environmentObject(globalState)
                .environmentObject(resultsManager)
        }
    }
}
