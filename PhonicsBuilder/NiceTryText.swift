import SwiftUI

struct NiceTryText: View {
    @State private var bouncing = false
    var body: some View {
        Image("NiceTry")
            .scaleEffect(bouncing ? 1.2 : 1.5)
            .padding(.top, 50)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 0.25).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                bouncing = true
            }
    }
}
