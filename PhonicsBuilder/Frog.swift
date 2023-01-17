import SwiftUI

struct Frog: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image("Frog")
                    .padding(100)
                    .scaleEffect(2.0)
                Spacer()
            }
        }
    }
}
