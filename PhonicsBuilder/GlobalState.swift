import SwiftUI

class GlobalState: ObservableObject {
    @Published var isRecording = false
    @Published var finishedRecording = false
    @Published var showingResultsScreen = false
    @Published var cameraAvailable = true
}
