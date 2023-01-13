import SwiftUI

struct ChunkView: View {
    @State private var chunkScale = 1.0
    let text: String
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom("Poppins", size: 150, relativeTo: .largeTitle))
                .scaleEffect(chunkScale)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.25)) {
                chunkScale = 1.5
            }
            withAnimation(.easeInOut(duration: 0.25).delay(0.25)) {
                chunkScale = 1.0
            }
        }
    }
}
