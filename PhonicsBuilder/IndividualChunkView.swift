import SwiftUI

struct IndividualChunkView: View {
    let text: String
    let score: Int
    var body: some View {
        ZStack {
            Color.white
            Text(text)
                .font(.custom("Poppins", size: 100))
            .foregroundColor(.black)
        }
        .frame(width: 250, height: 250)
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(Color("ExcellentColor"), lineWidth: 10)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(radius: 10)
    }
}
