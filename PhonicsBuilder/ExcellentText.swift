import SwiftUI

struct ExcellentText: View {
    @State private var bouncing = false
    var body: some View {
        Image("Excellent")
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .padding()
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 0.25).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                bouncing = true
            }
    }
}
