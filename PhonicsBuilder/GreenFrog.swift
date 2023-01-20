import SwiftUI

struct GreenFrog: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Image("GreenFrog")
                    .scaleEffect(2.0)
                    .padding(100)
            }
            Spacer()
        }
    }
}
