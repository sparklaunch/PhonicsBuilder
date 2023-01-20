import SwiftUI
import AVFoundation

struct ChunkView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var textSize = 0.0
    let text: String
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom("EFUTURE4_EB", size: 150))
                .scaleEffect(textSize)
                .onAppear {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 3)) {
                        textSize = 1.0
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        textSize = 1.5
                    }
                    withAnimation(.easeInOut(duration: 0.25).delay(0.25)) {
                        textSize = 1.0
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
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
