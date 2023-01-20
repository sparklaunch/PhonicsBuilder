import SwiftUI

struct ChunksView: View {
    var firstChunk: String {
        return Camera.shared.results.isEmpty ? "" : Camera.shared.results.first!.lowercased()
    }
    var middleChunk: String {
        return Camera.shared.results.isEmpty ? "" : Camera.shared.results[1].lowercased()
    }
    var lastChunk: String {
        return Camera.shared.results.isEmpty ? "" : Camera.shared.results.last!.lowercased()
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
        .opacity(Camera.shared.results.isEmpty ? 0 : 1)
    }
}
