import SwiftUI

struct IconsView: View {
    @State private var microphoneScaleAndOpacity = 0.0
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        // TODO: MICROPHONE BUTTON.
                    } label: {
                        LottieView(jsonName: "Microphone")
                            .frame(width: 100, height: 100)
                            .scaleEffect(microphoneScaleAndOpacity)
                            .opacity(microphoneScaleAndOpacity)
                            .padding()
                            .onAppear {
                                withAnimation {
                                    microphoneScaleAndOpacity = 1.0
                                }
                            }
                            .onDisappear {
                                withAnimation {
                                    microphoneScaleAndOpacity = 0.0
                                }
                            }
                    }
                    Spacer()
                }
            }
        }
    }
}
