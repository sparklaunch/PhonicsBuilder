import SwiftUI

struct RetryButton: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        Image("Retry")
            .scaleEffect(isPhone ? 1.2 : 2.0)
            .padding(.bottom, isPhone ? .zero : 100)
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
