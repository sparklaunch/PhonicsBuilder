import SwiftUI
import AVFoundation

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

struct PronunciationResult: Codable, Equatable {
    let totalScore: Double
    let words: [WordResult]
    enum CodingKeys: String, CodingKey {
        case totalScore = "total_score"
        case words
    }
}

class RecordingManager: ObservableObject {
    static let shared = RecordingManager()
    private init() {}
    var audioRecorder: AVAudioRecorder!
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.record, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print(error.localizedDescription)
        }
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        let targetURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("record.aac")
        do {
            audioRecorder = try AVAudioRecorder(url: targetURL, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print(error.localizedDescription)
        }
    }
    func stopRecording() {
        audioRecorder.stop()
        sendRecordedAudio()
    }
    func sendRecordedAudio() {
        let endPoint = URL(string: "http://3.38.222.142/pron")!
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: endPoint)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(boundary: boundary)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            do {
                let anyJSON = try JSONSerialization.jsonObject(with: data!)
                let jsonData = try JSONSerialization.data(withJSONObject: anyJSON)
                let results = try JSONDecoder().decode(PronunciationResult.self, from: jsonData)
                print(results)
                DispatchQueue.main.async {
                    ResultsManager.shared.results = results
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func createBody(boundary: String) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        let targetURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("record.aac")
        do {
            let data = try Data(contentsOf: targetURL)
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"audio\"; filename=\"record.aac\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
            body.append(data)
            body.append("\r\n".data(using: .utf8)!)
            
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"words\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            body.append(Camera.shared.results.joined(separator: ",").data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
        } catch {
            print(error.localizedDescription)
        }
        body.append(boundaryPrefix.data(using: .utf8)!)
        return body
    }
}
