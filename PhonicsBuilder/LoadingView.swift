import SwiftUI

struct LoadingView: View {
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
            ProgressView()
        }
        .onTapGesture {
            withAnimation {
                globalState.finishedRecording = false
                globalState.showingResultsScreen = true
            }
        }
    }
}
