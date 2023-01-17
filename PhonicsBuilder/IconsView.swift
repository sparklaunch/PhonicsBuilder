import SwiftUI

struct IconsView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    MegaphoneView()
                    Spacer()
                }
            }
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    MicrophoneView()
                }
            }
        }
    }
}
