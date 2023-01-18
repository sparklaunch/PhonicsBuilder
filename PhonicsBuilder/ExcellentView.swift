import SwiftUI

struct ExcellentView: View {
    var body: some View {
        ZStack {
            Color("ExcellentColor")
            ExcellentBackground()
            VStack {
                ExcellentText()
                Spacer()
                    .frame(height: 100)
                ChunksContainerView()
                Spacer()
            }
            LeftArrow()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            SoundManager.shared.playSound("excellent", withExtension: "mp3")
        }
    }
}

struct ExcellentView_Previews: PreviewProvider {
    static var previews: some View {
        ExcellentView()
    }
}
