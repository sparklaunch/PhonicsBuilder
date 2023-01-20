import SwiftUI

struct Crocodile: View {
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            HStack(spacing: .zero) {
                Image("Crocodile")
                    .scaleEffect(2.0)
                    .padding(100)
                Spacer()
            }
        }
    }
}
