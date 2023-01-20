import SwiftUI

struct RetryButton: View {
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        Image("Retry")
            .scaleEffect(2.0)
            .padding(.bottom, 100)
            .onTapGesture {
                withAnimation {
                    globalState.showingResultsScreen = false
                    globalState.finishedRecording = false
                    globalState.isRecording = true
                }
                RecordingManager.shared.startRecording()
            }
    }
}
