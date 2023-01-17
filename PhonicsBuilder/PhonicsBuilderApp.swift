import SwiftUI

@main
struct PhonicsBuilderApp: App {
    @StateObject private var camera = Camera.shared
    @StateObject private var globalState = GlobalState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(camera)
                .environmentObject(globalState)
        }
    }
}
