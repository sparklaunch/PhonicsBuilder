import SwiftUI

struct ExcellentView: View {
    var body: some View {
        ZStack {
            Color("ExcellentColor")
            ExcellentBackground()
            VStack {
                ExcellentText()
                ChunksContainerView()
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ExcellentView_Previews: PreviewProvider {
    static var previews: some View {
        ExcellentView()
    }
}
