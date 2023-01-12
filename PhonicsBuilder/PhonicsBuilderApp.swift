import SwiftUI

@main
struct PhonicsBuilderApp: App {
    @StateObject private var camera = Camera.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(camera)
        }
    }
}
