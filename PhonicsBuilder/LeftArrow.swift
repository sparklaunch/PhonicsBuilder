import SwiftUI

struct LeftArrow: View {
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        VStack {
            HStack {
                LottieView(jsonName: "Left")
                    .frame(width: 100, height: 100)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            globalState.showingResultsScreen = false
                            globalState.isRecording = false
                        }
                    }
                Spacer()
            }
            Spacer()
        }
    }
}
