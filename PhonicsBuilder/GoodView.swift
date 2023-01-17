import SwiftUI

struct GoodView: View {
    var body: some View {
        ZStack {
            Color("GoodColor")
            VStack {
                GoodText()
            }
        }
    }
}
