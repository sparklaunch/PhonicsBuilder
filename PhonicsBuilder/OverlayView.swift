import SwiftUI

struct OverlayView: View {
    @Binding var iconsShown: Bool
    let height: Double
    var body: some View {
        ZStack {
            BackdropView(height: height)
            ChunksView()
            if iconsShown {
                IconsView()
            }
        }
    }
}
