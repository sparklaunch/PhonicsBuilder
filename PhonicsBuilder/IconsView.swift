import SwiftUI

struct IconsView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        
                    } label: {
                        LottieView(jsonName: "Microphone")
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}
