import SwiftUI

struct WordResult: Codable, Equatable {
    let score: Double
    let word: String
    let alphabet: [String]
    enum CodingKeys: String, CodingKey {
        case score
        case word
        case alphabet = "arpabet"
    }
}
