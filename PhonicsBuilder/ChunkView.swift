import SwiftUI

struct ChunkView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.custom("Poppins", size: 150, relativeTo: .largeTitle))
            .frame(maxWidth: .infinity)
    }
}
