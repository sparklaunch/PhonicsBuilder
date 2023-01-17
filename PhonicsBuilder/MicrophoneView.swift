import SwiftUI

struct MicrophoneView: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var microphoneScaleAndOpacity = 0.0
    var body: some View {
        Button {
            withAnimation {
                globalState.isRecording = true
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
