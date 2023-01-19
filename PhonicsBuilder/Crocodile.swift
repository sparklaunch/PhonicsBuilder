import SwiftUI

struct Crocodile: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Image("Crocodile")
                    .scaleEffect(2.0)
                    .padding(100)
                Spacer()
            }
        }
    }
}
