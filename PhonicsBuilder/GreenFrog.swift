import SwiftUI

struct GreenFrog: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                Image("GreenFrog")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
            }
            Spacer()
        }
    }
}
