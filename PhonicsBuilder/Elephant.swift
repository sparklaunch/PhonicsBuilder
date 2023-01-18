import SwiftUI

struct Elephant: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
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
