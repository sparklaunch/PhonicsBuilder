import SwiftUI
import AVFoundation

var player: AVAudioPlayer?

class TTSManager: ObservableObject {
    static let shared = TTSManager()
    private init() {}
    func requestTTS() {
        let strings = Camera.shared.results
        guard let endPoint = URL(string: "http://3.38.222.142/tts") else {
            print("URL error.")
            return
        }
        let queryString = "words=\(strings[0]),\(strings[1]),\(strings[2])"
        var request = URLRequest(url: endPoint)
        request.httpMethod = "POST"
        request.setValue("feafc8ee6fa249d496369ac40b256b95", forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = queryString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let _ = data else {
                print("No data.")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Response code not 200")
                return
            }
            do {
                let decodedData = Data(base64Encoded: data!)!
                let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                let targetURL = cachesDirectory.appendingPathComponent("tts.wav")
                try decodedData.write(to: targetURL)
                player = try AVAudioPlayer(data: decodedData)
                player?.play()
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
