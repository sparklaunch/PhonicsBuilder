import SwiftUI

struct OverlayView: View {
    @EnvironmentObject private var globalState: GlobalState
    @Binding var iconsShown: Bool
    let height: Double
    var body: some View {
        ZStack {
            BackdropView(height: height)
            ChunksView()
            if iconsShown {
                IconsView()
            }
            if globalState.isRecording {
                RecordingView()
            }
        }
    }
}
