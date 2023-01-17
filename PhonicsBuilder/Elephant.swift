import SwiftUI

struct Elephant: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("Elephant")
                    .scaleEffect(2.0)
                    .padding(100)
            }
        }
    }
}
