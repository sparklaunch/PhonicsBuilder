import SwiftUI

struct SpeakNowText: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    @State private var bouncing = false
    var body: some View {
        Text("Speak Now")
            .font(.custom(Constants.eFutureFont, size: isPhone ? 48 : 64))
            .foregroundColor(Color("MainColor"))
            .padding()
            .scaleEffect(bouncing ? 1.0 : 1.2)
            .animation(.linear(duration: 0.5).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                withAnimation {
                    bouncing = true                    
                }
            }
    }
}
