import SwiftUI

struct IconsView: View {
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                Spacer()
                HStack(spacing: .zero) {
                    Spacer()
                    MegaphoneView()
                    Spacer()
                }
            }
            VStack(spacing: .zero) {
                Spacer()
                HStack(spacing: .zero) {
                    Spacer()
                    MicrophoneView()
                }
            }
        }
    }
}
