import SwiftUI
import AVFoundation

struct GoodView: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
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
                GoodText()
                Spacer()
                    .frame(height: isPhone ? 10 : 100)
                ChunksContainerView()
                Spacer()
                RetryButton()
            }
            LeftArrow()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            playGoodSound()
        }
    }
}
