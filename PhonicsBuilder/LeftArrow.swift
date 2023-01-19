import SwiftUI

struct LeftArrow: View {
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("Back")
                    .scaleEffect(2)
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
