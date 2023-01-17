import SwiftUI

struct RecordingView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
            VStack(spacing: 0) {
                SpeakNowText()
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    ListeningMicrophone()
                    Spacer()
                }
            }
        }
    }
}
