import SwiftUI

struct LoadingView: View {
    @EnvironmentObject private var globalState: GlobalState
    @EnvironmentObject private var resultsManager: ResultsManager
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
            ProgressView()
                .scaleEffect(3)
        }
        .onChange(of: resultsManager.id) { _ in
            withAnimation {
                globalState.finishedRecording = false
                globalState.showingResultsScreen = true
            }
        }
    }
}
