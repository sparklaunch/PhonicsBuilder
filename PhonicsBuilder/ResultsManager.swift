import SwiftUI

class ResultsManager: ObservableObject {
    @Published var results = PronunciationResult(totalScore: 0.0, words: [WordResult(score: 0.0, word: "", alphabet: [""])])
    static let shared = ResultsManager()
    private init() {}
}
