import SwiftUI

struct ExcellentBackground: View {
    var body: some View {
        ZStack {
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
}
