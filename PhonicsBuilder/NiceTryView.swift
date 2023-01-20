import SwiftUI
import AVFoundation

struct NiceTryView: View {
    @State private var audioPlayer: AVAudioPlayer!
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
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
                    .frame(height: isPhone ? 10 : 100)
                ChunksContainerView()
                if !isPhone {
                    Spacer()                    
                }
                RetryButton()
            }
            LeftArrow()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            playNiceTrySound()
        }
    }
}
