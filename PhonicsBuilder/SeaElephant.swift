import SwiftUI

struct SeaElephant: View {
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()
            HStack(spacing: .zero) {
                Image("SeaElephant")
                    .scaleEffect(2.0)
                    .padding(100)
                Spacer()
            }
        }
    }
}
