import SwiftUI
import AVFoundation

struct GoodView: View {
    @State private var audioPlayer: AVAudioPlayer!
    func playGoodSound() {
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
            Color("GoodColor")
            GoodBackground()
            VStack {
                ExcellentText()
                Spacer()
                    .frame(height: 100)
                ChunksContainerView()
                Spacer()
            }
            LeftArrow()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            playGoodSound()
        }
    }
}
