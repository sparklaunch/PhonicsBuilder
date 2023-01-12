import SwiftUI

struct ChunksView: View {
    @EnvironmentObject var camera: Camera
    var firstChunk: String {
        return camera.results.isEmpty ? "" : camera.results.first!.lowercased()
    }
    var middleChunk: String {
        return camera.results.isEmpty ? "" : camera.results[1].lowercased()
    }
    var lastChunk: String {
        return camera.results.isEmpty ? "" : camera.results.last!.lowercased()
    }
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                ChunkView(text: firstChunk)
                ChunkView(text: middleChunk)
                ChunkView(text: lastChunk)
            }
            .foregroundColor(Color("MainColor"))
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .opacity(camera.results.isEmpty ? 0 : 1)
    }
}
