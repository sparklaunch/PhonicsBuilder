import SwiftUI
import AVKit

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    func playSound(_ fileName: String, withExtension ext: String, withPlayer player: inout AVAudioPlayer) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ext) else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    private init() {}
}
