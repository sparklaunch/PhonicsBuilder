import SwiftUI

struct RootView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                PreView()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .overlay(OverlayView(height: geometry.size.height), alignment: .center)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Camera.shared.verifyPermissions()
        }
        .onChange(of: Camera.shared.id) { _ in
            if !Camera.shared.results.isEmpty {
                withAnimation {
                    Camera.shared.iconsShown = true                    
                }
                TTSManager.shared.requestTTS()
            }
        }
    }
}
