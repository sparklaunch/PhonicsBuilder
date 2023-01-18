import SwiftUI

struct SpeakNowText: View {
    @State private var bouncing = false
    var body: some View {
        Text("Speak Now")
            .font(.custom("Poppins", size: 64))
            .foregroundColor(Color("MainColor"))
            .padding()
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                bouncing = true
            }
    }
}
