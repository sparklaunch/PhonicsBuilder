import SwiftUI

struct MicrophoneView: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var microphoneScaleAndOpacity = 0.0
    var body: some View {
        Button {
            SoundManager.shared.playSound("click", withExtension: "wav")
            withAnimation {
                globalState.isRecording = true
                RecordingManager.shared.startRecording()
            }
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
                        microphoneScaleAndOpacity = 0.0
                    }
                }
        }
    }
}
