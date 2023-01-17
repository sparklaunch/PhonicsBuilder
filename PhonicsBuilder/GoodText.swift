import SwiftUI

struct GoodText: View {
    @State private var bouncing = false
    var body: some View {
        Text("Good")
            .font(.custom("Poppins", size: 100))
            .foregroundColor(Color("MainColor"))
            .scaleEffect(bouncing ? 1.0 : 1.5)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                bouncing = true
            }
    }
}
