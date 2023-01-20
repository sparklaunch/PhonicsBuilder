import SwiftUI

struct ListeningMicrophone: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    @EnvironmentObject private var globalState: GlobalState
    @State private var bouncing = false
    var body: some View {
        LottieView(jsonName: "Listening")
            .frame(width: isPhone ? 200 : 300, height: isPhone ? 200 : 300)
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: true), value: bouncing)
            .padding()
            .onAppear {
                withAnimation {
                    bouncing = true
                }
            }
            .onTapGesture {
                RecordingManager.shared.stopRecording()
                withAnimation {
                    globalState.finishedRecording = true
                }
            }
    }
}
