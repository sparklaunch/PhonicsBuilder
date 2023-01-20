import SwiftUI

struct PronunciationResult: Codable, Equatable {
    let totalScore: Double
    let words: [WordResult]
    enum CodingKeys: String, CodingKey {
        case totalScore = "total_score"
        case words
    }
}
