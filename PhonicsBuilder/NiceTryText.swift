import SwiftUI

struct NiceTryText: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    @State private var bouncing = false
    var body: some View {
        Image("NiceTry")
            .scaleEffect(bouncing ? 1.2 * (isPhone ? 0.8 : 1.0) : 1.5 * (isPhone ? 0.8 : 1.0))
            .padding(.top, isPhone ? .zero : 50)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 0.25).repeatForever(autoreverses: true), value: bouncing)
            .onAppear {
                withAnimation {
                    bouncing = true                    
                }
            }
    }
}
