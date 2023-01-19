import SwiftUI

struct ListeningMicrophone: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var bouncing = false
    var body: some View {
        LottieView(jsonName: "Listening")
            .frame(width: 300, height: 300)
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: true), value: bouncing)
            .padding()
            .onAppear {
                bouncing = true
            }
            .onTapGesture {
                RecordingManager.shared.stopRecording()
                withAnimation {
                    globalState.finishedRecording = true
                }
            }
    }
}
