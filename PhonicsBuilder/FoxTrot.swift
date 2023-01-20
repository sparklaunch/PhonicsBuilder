import SwiftUI

struct FoxTrot: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Image("FoxTrot")
                    .scaleEffect(2.0)
                    .padding(100)
            }
            Spacer()
        }
    }
}
