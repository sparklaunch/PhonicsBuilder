import SwiftUI

struct RootView: View {
    @EnvironmentObject var camera: Camera
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Preview()
                    .rotationEffect(.degrees(-90))
                    .scaledToFill()
                Button {
                    withAnimation {
                        camera.results = ["br", "a", "mp"]                        
                    }
                } label: {
                    Text("Test now")
                        .font(.largeTitle)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .overlay(
                ZStack {
                    BackdropView(height: geometry.size.height)
                    ChunksView()
                }
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
