import SwiftUI

extension ContentView {
    var splashScreenView: some View {
        ZStack {
            Color("MainColor")
            Image("Splash")
        }
        .edgesIgnoringSafeArea(.all)
    }
}
