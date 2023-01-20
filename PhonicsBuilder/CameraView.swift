import SwiftUI

struct CameraView: View {
    @EnvironmentObject private var camera: Camera
    var body: some View {
        VStack {
            LottieView(jsonName: "Camera")
                .frame(width: 100, height: 100)
                .background(
                    Circle()
                        .foregroundColor(.white.opacity(0.8))
                )
                .padding()
                .onTapGesture {
                    camera.capturePhoto()
                }
            Spacer()
        }
    }
}
