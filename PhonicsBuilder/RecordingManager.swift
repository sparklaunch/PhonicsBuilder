import SwiftUI
import AVFoundation

class RecordingManager {
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
            return
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
            return
        }
    }
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print(error.localizedDescription)
            return
        }
        sendRecordedAudio()
    }
    func sendRecordedAudio() {
        let endPoint = URL(string: Constants.pronunciationEndPoint)!
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
                    ResultsManager.shared.id = UUID()
                }
                CacheManager.clearCachesDirectory()
            } catch {
                print(error.localizedDescription)
                return
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
