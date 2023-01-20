import SwiftUI

struct RootView: View {
    @EnvironmentObject var camera: Camera
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                PreView()
                Button {
                    withAnimation {
                        camera.results = ["br", "a", "mp"]                        
                    }
                } label: {
                    if camera.results.isEmpty {
                        Text("Test now")
                            .font(.largeTitle)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .overlay(OverlayView(iconsShown: $camera.iconsShown, height: geometry.size.height), alignment: .center)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Camera.verifyPermissions()
        }
        .onChange(of: camera.id) { _ in
            if !camera.results.isEmpty {
                camera.iconsShown = true
                TTSManager.shared.requestTTS()
            }
        }
    }
}
