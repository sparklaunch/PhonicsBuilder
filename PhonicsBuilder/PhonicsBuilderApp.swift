import SwiftUI

@main
struct PhonicsBuilderApp: App {
    @StateObject private var globalState = GlobalState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalState)
        }
    }
}
