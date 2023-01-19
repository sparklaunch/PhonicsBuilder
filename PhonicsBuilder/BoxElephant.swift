import SwiftUI

struct BoxElephant: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Image("BoxElephant")
                    .scaleEffect(2.0)
                    .padding(100)
            }
            Spacer()
        }
    }
}
