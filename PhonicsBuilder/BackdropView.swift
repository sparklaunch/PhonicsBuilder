import SwiftUI

struct BackdropView: View {
    let height: Double
    var body: some View {
        VStack(spacing: 0) {
            DimmedView(height: height)
            BoundaryView(height: height)
            DimmedView(height: height)
        }
    }
}
