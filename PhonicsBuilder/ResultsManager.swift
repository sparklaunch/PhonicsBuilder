import SwiftUI

class ResultsManager: ObservableObject {
    @Published var id = UUID()
    @Published var results = PronunciationResult(totalScore: .zero, words: [WordResult(score: .zero, word: "", alphabet: [""])])
    static let shared = ResultsManager()
    private init() {}
}
