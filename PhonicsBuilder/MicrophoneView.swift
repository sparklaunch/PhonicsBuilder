import SwiftUI
import AVFoundation

struct MicrophoneView: View {
    @EnvironmentObject private var globalState: GlobalState
    @State private var audioPlayer: AVAudioPlayer!
    @State private var microphoneScaleAndOpacity = 0.0
    var body: some View {
        Button {
            guard let clickURL = Bundle.main.url(forResource: "click", withExtension: "wav") else {
                print("Failed to find click sound")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: clickURL)
            } catch {
                print(error.localizedDescription)
            }
            if audioPlayer.prepareToPlay() {
                audioPlayer.play()
            } else {
                print("Failed to prepare to play.")
            }
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
