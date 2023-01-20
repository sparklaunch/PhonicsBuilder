import SwiftUI

struct ChunksContainerView: View {
    var scores: [Grade] {
        return ResultsManager.shared.results.words.map { word in
            let score = Int(word.score)
            switch score {
                case Constants.excellentThreshold...:
                    return Grade.excellent
                case Constants.goodThreshold...:
                    return Grade.good
                case Constants.niceTryThreshold...:
                    return Grade.niceTry
                default:
                    return Grade.poor
            }
        }
    }
    var texts: [String] {
        return ResultsManager.shared.results.words.map { word in
            return word.word.lowercased()
        }
    }
    var body: some View {
        HStack(spacing: 30) {
            IndividualChunkView(text: texts[0], score: scores[0])
            IndividualChunkView(text: texts[1], score: scores[1])
            IndividualChunkView(text: texts[2], score: scores[2])
        }
    }
}
