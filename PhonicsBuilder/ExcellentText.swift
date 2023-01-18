import SwiftUI

struct ExcellentText: View {
    @State private var bouncing = false
    var body: some View {
        Text("Excellent")
            .font(.custom("Poppins", size: 100))
            .foregroundColor(Color("MainColor"))
            .padding()
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 0.25).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                bouncing = true
            }
    }
}
