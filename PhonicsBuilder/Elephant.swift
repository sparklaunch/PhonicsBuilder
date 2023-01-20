import SwiftUI

struct Elephant: View {
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            HStack(spacing: .zero) {
                Spacer()
                Image("Elephant")
                    .scaleEffect(2.0)
                    .padding(100)
                    .offset(y: 100)
            }
            Spacer()
        }
    }
}
