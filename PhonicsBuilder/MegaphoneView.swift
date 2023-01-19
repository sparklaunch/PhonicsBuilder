import SwiftUI
import AVFoundation

struct MegaphoneView: View {
    @State private var megaphoneScaleAndOpacity = 0.0
    @State private var audioPlayer: AVAudioPlayer!
    var body: some View {
        Button {
            let targetURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("tts.wav")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: targetURL)
            } catch {
                print(error.localizedDescription)
            }
            audioPlayer.play()
        } label: {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white.opacity(0.3))
                LottieView(jsonName: "Megaphone")
                    .frame(width: 100, height: 100)
                    .padding()
            }
            .scaleEffect(megaphoneScaleAndOpacity)
            .opacity(megaphoneScaleAndOpacity)
            .onAppear {
                withAnimation {
                    megaphoneScaleAndOpacity = 1.0
                }
            }
            .onDisappear {
                withAnimation {
                    megaphoneScaleAndOpacity = 0.0
                }
            }
        }
    }
}

