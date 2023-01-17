import SwiftUI

struct ChunksContainerView: View {
    var body: some View {
        HStack(spacing: 30) {
            IndividualChunkView(text: "sl", score: 3)
            IndividualChunkView(text: "u", score: 2)
            IndividualChunkView(text: "mp", score: 1)
        }
    }
}
