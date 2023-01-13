import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    var body: some View {
        ZStack {
            RootView()
                .zIndex(0)
            if isLoading {
                splashScreenView
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                withAnimation {
                    isLoading.toggle()
                }
            })
        }
    }
}
