import SwiftUI
import AVFoundation

struct ChunkView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var chunkScale = 1.0
    let text: String
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom("EFUTURE4_EB", size: 150, relativeTo: .largeTitle))
                .scaleEffect(chunkScale)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.25)) {
                chunkScale = 1.5
            }
            withAnimation(.easeInOut(duration: 0.25).delay(0.25)) {
                chunkScale = 1.0
            }
            guard let soundURL = Bundle.main.url(forResource: text, withExtension: "mp3") else {
                print("Failed to load chunk sound.")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
