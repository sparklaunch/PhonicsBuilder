import SwiftUI

struct FoxTrot: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Image("FoxTrot")
                    .scaleEffect(2.0)
                    .padding(100)
            }
            Spacer()
        }
    }
}
