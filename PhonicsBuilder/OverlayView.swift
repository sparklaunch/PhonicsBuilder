import SwiftUI

struct OverlayView: View {
    @EnvironmentObject private var globalState: GlobalState
    @EnvironmentObject private var camera: Camera
    let height: Double
    var body: some View {
        ZStack {
            BackdropView(height: height)
            ChunksView()
            if globalState.cameraAvailable {
                CameraView()
            }
            if camera.iconsShown {
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
