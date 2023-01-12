import SwiftUI

struct BoundaryView: View {
    let height: Double
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    BoundaryCornerView(edges: [.leading, .top])
                    Spacer()
                    BoundaryCornerView(edges: [.trailing, .top])
                }
                Spacer()
                HStack {
                    BoundaryCornerView(edges: [.bottom, .leading])
                    Spacer()
                    BoundaryCornerView(edges: [.bottom, .trailing])
                }
            }
        }
        .frame(height: height * 0.6)
    }
}
