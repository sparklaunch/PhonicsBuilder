import SwiftUI
import AVFoundation

struct NiceTryView: View {
    @State private var audioPlayer: AVAudioPlayer!
    func playNiceTrySound() {
        guard let soundURL = Bundle.main.url(forResource: "good", withExtension: "mp3") else {
            print("Unable to find good.mp3")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print(error.localizedDescription)
        }
        if audioPlayer.prepareToPlay() {
            audioPlayer.play()
        } else {
            print("Failed to prepare to play.")
        }
    }
    var body: some View {
        ZStack {
            Color("NiceTryColor")
            NiceTryBackground()
            VStack {
                NiceTryText()
                Spacer()
                    .frame(height: 100)
                ChunksContainerView()
                Spacer()
            }
            LeftArrow()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            playNiceTrySound()
        }
    }
}
