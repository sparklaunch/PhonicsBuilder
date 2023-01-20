import SwiftUI

struct BackdropView: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    let height: Double
    var body: some View {
        VStack(spacing: .zero) {
            if !isPhone {
                DimmedView(height: height)
            }
            BoundaryView(height: height)
            if !isPhone {
                DimmedView(height: height)
            }
        }
    }
}
