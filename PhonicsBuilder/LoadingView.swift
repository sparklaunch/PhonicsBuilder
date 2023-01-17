import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
            ProgressView()
        }
    }
}
