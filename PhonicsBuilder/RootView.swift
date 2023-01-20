import SwiftUI

struct RootView: View {
    @EnvironmentObject private var camera: Camera
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
            camera.verifyPermissions()
        }
        .onChange(of: camera.id) { _ in
            if !camera.results.isEmpty {
                withAnimation {
                    camera.iconsShown = true
                }
                TTSManager.shared.requestTTS()
            }
        }
    }
}
