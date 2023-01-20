import SwiftUI

struct BoundaryView: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
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
        .frame(height: isPhone ? height * 1.0 : height * 0.6)
    }
}
