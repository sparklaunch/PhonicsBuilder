import SwiftUI

struct ListeningMicrophone: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var bouncing = false
    var body: some View {
        LottieView(jsonName: "Listening")
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                bouncing = true
            }
            .onTapGesture {
                withAnimation {
                    globalState.finishedRecording = true
                }
            }
    }
}
