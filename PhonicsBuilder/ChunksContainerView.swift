import SwiftUI

struct ChunksContainerView: View {
    @EnvironmentObject private var resultsManager: ResultsManager
    var scores: [Grade] {
        return resultsManager.results.words.map { word in
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
        return resultsManager.results.words.map { word in
            return word.word.lowercased()
        }
    }
    var body: some View {
        HStack(spacing: 30) {
            ForEach(0 ..< 3) { index in
                IndividualChunkView(text: texts[index], score: scores[index])
            }
        }
    }
}
