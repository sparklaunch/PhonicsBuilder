import SwiftUI

struct BoundaryCornerView: View {
    let edges: [Edge]
    var body: some View {
        Rectangle()
            .opacity(0)
            .border(width: 10, edges: edges, color: Color("MainColor"))
            .frame(width: 100, height: 100)
    }
}
