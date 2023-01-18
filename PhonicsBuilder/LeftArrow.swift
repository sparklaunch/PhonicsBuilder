import SwiftUI

struct LeftArrow: View {
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                LottieView(jsonName: "Left")
                    .frame(width: 100, height: 100)
                    .padding(50)
                    .onTapGesture {
                        withAnimation {
                            globalState.showingResultsScreen = false
                            globalState.isRecording = false
                        }
                    }
            }
        }
    }
}
