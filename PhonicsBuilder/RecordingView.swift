import SwiftUI

struct RecordingView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
            VStack(spacing: .zero) {
                SpeakNowText()
                Spacer()
                HStack(spacing: .zero) {
                    Spacer()
                    ListeningMicrophone()
                    Spacer()
                }
            }
        }
    }
}
