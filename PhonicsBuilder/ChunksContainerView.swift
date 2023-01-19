import SwiftUI

struct ChunksContainerView: View {
    @EnvironmentObject private var resultsManager: ResultsManager
    var scores: [Int] {
        return resultsManager.results.words.map { word in
            let score = Int(word.score)
            switch score {
                case 70...:
                    return 3
                case 30...:
                    return 2
                case 10...:
                    return 1
                default:
                    return 0
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
            IndividualChunkView(text: texts[0], score: scores[0])
            IndividualChunkView(text: texts[1], score: scores[1])
            IndividualChunkView(text: texts[2], score: scores[2])
        }
    }
}
