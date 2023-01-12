import SwiftUI

struct DimmedView: View {
    let height: Double
    var body: some View {
        Rectangle()
            .foregroundColor(.black.opacity(0.5))
            .frame(height: height * 0.2)
    }
}
