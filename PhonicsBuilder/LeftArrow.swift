import SwiftUI

struct LeftArrow: View {
    var body: some View {
        VStack {
            HStack {
                LottieView(jsonName: "Left")
                    .frame(width: 100, height: 100)
                    .padding()
                Spacer()
            }
            Spacer()
        }
    }
}
