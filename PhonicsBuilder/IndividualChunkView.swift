import SwiftUI
import AVFoundation

struct IndividualChunkView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scale = 1.0
    let text: String
    let score: Grade
    var borderColor: Color {
        switch score {
            case .excellent:
                return Color("ExcellentColor")
            case .good:
                return Color("GoodColor")
            case .niceTry:
                return Color("NiceTryColor")
            default:
                return Color("PoorColor")
        }
    }
    var face: Image {
        switch score {
            case .excellent:
                return Image("HappyFace")
            case .good:
                return Image("IdleFace")
            default:
                return Image("UnsureFace")
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Color.white
                Text(text)
                    .font(.custom(Constants.eFutureFont, size: Constants.resultsChunkFontSize))
                    .foregroundColor(.black)
                    .scaleEffect(scale)
                    .onTapGesture {
                        withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                            scale = 1.5
                        }
                        withAnimation(.interpolatingSpring(stiffness: 100, damping: 10).delay(0.25)) {
                            scale = 1.0
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
            .frame(width: 250, height: 250)
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(borderColor, lineWidth: 20)
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 10)
            .overlay(
                face
                    .scaleEffect(2.0)
                    .offset(y: -30)
                , alignment: .top
            )
        }
    }
}
