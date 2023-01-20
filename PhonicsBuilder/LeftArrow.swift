import SwiftUI

struct LeftArrow: View {
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    @EnvironmentObject private var globalState: GlobalState
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("Back")
                    .scaleEffect(isPhone ? 1.2 : 2.0)
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
