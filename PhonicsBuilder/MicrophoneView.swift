import SwiftUI

struct MicrophoneView: View {
    @State private var microphoneScaleAndOpacity = 0.0
    var body: some View {
        Button {
            // TODO: MICROPHONE BUTTON.
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
