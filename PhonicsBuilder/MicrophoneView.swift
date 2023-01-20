import SwiftUI
import AVFoundation

struct MicrophoneView: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var microphoneScaleAndOpacity: Double = .zero
    var body: some View {
        Button {
            withAnimation {
                globalState.isRecording = true
            }
            RecordingManager.shared.startRecording()
        } label: {
            LottieView(jsonName: "Microphone")
                .frame(width: 100, height: 100)
                .scaleEffect(microphoneScaleAndOpacity)
                .opacity(microphoneScaleAndOpacity)
                .padding()
                .onAppear {
                    withAnimation {
                        microphoneScaleAndOpacity = 1.0
                    }
                }
                .onDisappear {
                    withAnimation {
                        microphoneScaleAndOpacity = .zero
                    }
                }
        }
    }
}
