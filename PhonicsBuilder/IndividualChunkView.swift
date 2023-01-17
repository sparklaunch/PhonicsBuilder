import SwiftUI

struct IndividualChunkView: View {
    let text: String
    let score: Int
    var borderColor: Color {
        switch score {
            case 3:
                return Color("ExcellentColor")
            case 2:
                return Color("GoodColor")
            case 0, 1:
                return Color("NiceTryColor")
            default:
                return Color("ExcellentColor")
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Color.white
                Text(text)
                    .font(.custom("Poppins", size: 100))
                    .foregroundColor(.black)
            }
            .frame(width: 250, height: 250)
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(borderColor, lineWidth: 20)
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 10)
            HStack {
                Star(filled: score >= 1)
                Star(filled: score >= 2)
                Star(filled: score >= 3)
            }
        }
    }
}
