import SwiftUI

struct ExcellentView: View {
    var body: some View {
        ZStack {
            Color("ExcellentColor")
            VStack {
                ExcellentText()
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
