import SwiftUI

struct RootView: View {
    @EnvironmentObject var camera: Camera
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Preview()
                    .rotationEffect(.degrees(-90))
                    .scaledToFill()
                Text(camera.results.isEmpty ? "No Input" : camera.results.joined(separator: ", "))
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .overlay(
                BackdropView(height: geometry.size.height)
                , alignment: .center)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Camera.verifyPermissions()
        }
        .onTapGesture {
            Camera.capturePhoto()
        }
    }
}
