import SwiftUI
import AVFoundation

struct ExcellentView: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    @State private var audioPlayer: AVAudioPlayer!
    func playExcellentSound() {
        guard let soundURL = Bundle.main.url(forResource: "excellent", withExtension: "mp3") else {
            print("Unable to find excellent.mp3")
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
            Color("ExcellentColor")
            ExcellentBackground()
            VStack {
                ExcellentText()
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
            playExcellentSound()
        }
    }
}
