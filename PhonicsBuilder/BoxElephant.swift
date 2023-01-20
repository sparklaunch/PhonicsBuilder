import SwiftUI

struct BoxElephant: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Image("BoxElephant")
                    .scaleEffect(2.0)
                    .padding(100)
            }
            Spacer()
        }
    }
}
