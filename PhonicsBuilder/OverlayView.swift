import SwiftUI

struct OverlayView: View {
    @EnvironmentObject private var globalState: GlobalState
    let height: Double
    var body: some View {
        ZStack {
            BackdropView(height: height)
            ChunksView()
            if globalState.cameraAvailable {
                CameraView()
            }
            if Camera.shared.iconsShown {
                IconsView()
            }
            if globalState.isRecording {
                RecordingView()
            }
            if globalState.finishedRecording {
                LoadingView()
            }
            if globalState.showingResultsScreen {
                ResultsView()
            }
        }
    }
}
