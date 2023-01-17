import SwiftUI

struct Star: View {
    var filled = false
    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .font(.largeTitle)
            .foregroundColor(.yellow)
    }
}
