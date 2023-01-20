import SwiftUI
import AVFoundation

class Camera: ObservableObject {
    @Published var results: [String] = []
    @Published var id = UUID()
    @Published var iconsShown = false
    static let shared = Camera()
    private init() {}
    class PreviewView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    class PhotoCaptureProcessor: NSObject, AVCapturePhotoCaptureDelegate {
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            print("didFinishProcessingPhoto started.")
            guard error == nil else {
                print("Error capturing photo: \(error!.localizedDescription).")
                return
            }
            guard let photoData = photo.fileDataRepresentation() else {
                print("fileDataRepresentation failed.")
                return
            }
            guard let uiImage = UIImage(data: photoData) else {
                print("Unable to generate UIImage from image data.")
                return
            }
            let rotatedUIImage = uiImage.rotate(radians: -.pi / 2)
            let croppedPhotos = Camera.shared.cropPhoto(rotatedUIImage)
            let jpegPhotos = croppedPhotos.compactMap { croppedPhoto in
                return croppedPhoto.jpegData(compressionQuality: 100)
            }
            let fileManager = FileManager.default
            let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            jpegPhotos.enumerated().forEach { (index, data) in
                let imageURL = url.appendingPathComponent("\(index).jpg")
                let imagePath = imageURL.path
                fileManager.createFile(atPath: imagePath, contents: data)
            }
            print("All three JPEG images were saved.")
            let uiImages = Camera.shared.loadImages()
            Camera.shared.sendRequest(uiImages: uiImages)
        }
    }
    let pixelFormatType = kCVPixelFormatType_32BGRA
    let captureProcessor = PhotoCaptureProcessor()
    let photoOutput = AVCapturePhotoOutput()
    let previewView = PreviewView()
    let captureSession = AVCaptureSession()
    let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    func verifyPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                prepareCapture()
                finishCapture()
                startSession()
            case .notDetermined:
                requestVideoPermission()
            case .denied:
                print("User denied permissions.")
                return
            case .restricted:
                print("Permissions restricted.")
                return
            default:
                print("Unknown permissions option.")
                return
        }
    }
    func requestVideoPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                self.prepareCapture()
                self.finishCapture()
                self.startSession()
            }
        }
    }
    func prepareCapture() {
        captureSession.beginConfiguration()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else {
            print("Initializing videoDeviceInput failed.")
            return
        }
        captureSession.addInput(videoDeviceInput)
    }
    func finishCapture() {
        guard captureSession.canAddOutput(photoOutput) else {
            print("Adding photoOutput failed.")
            return
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
    }
    func getPreview() -> UIView {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.connection?.videoOrientation = .landscapeLeft
        previewView.videoPreviewLayer.session = captureSession
        return previewView
    }
    func startSession() {
        captureSession.startRunning()
    }
    func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings(format: [kCVPixelBufferPixelFormatTypeKey as String: pixelFormatType])
        photoOutput.capturePhoto(with: photoSettings, delegate: captureProcessor)
        print("Photo captured.")
    }
    func loadPhoto() -> UIImage? {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let photoURL = url.appendingPathComponent("image.jpg")
        let photoPath = photoURL.path
        guard fileManager.fileExists(atPath: photoPath) else {
            print("image.jpg doesn't exist.")
            return nil
        }
        guard let data = try? Data(contentsOf: photoURL) else {
            print("Conversion from URL to Data failed.")
            return nil
        }
        guard let uiImage = UIImage(data: data) else {
            print("Conversion from Data to UIImage failed.")
            return nil
        }
        return uiImage
    }
    func cropPhoto(_ uiImage: UIImage) -> [UIImage] {
        let width = uiImage.size.width
        let height = uiImage.size.height
        let firstCropRect = CGRect(x: .zero, y: height * 0.2, width: width * 0.33, height: height * 0.6)
        let secondCropRect = CGRect(x: width * 0.33, y: height * 0.2, width: width * 0.33, height: height * 0.6)
        let thirdCropRect = CGRect(x: width * 0.66, y: height * 0.2, width: width * 0.33, height: height * 0.6)
        var cropResults: [UIImage] = []
        for cropRect in [firstCropRect, secondCropRect, thirdCropRect] {
            guard let cgImage = uiImage.cgImage else {
                print("Conversion from UIImage to CGImage for cropping failed.")
                return [UIImage()]
            }
            guard let result = cgImage.cropping(to: cropRect) else {
                print("Cropping process failed.")
                return [UIImage()]
            }
            cropResults.append(UIImage(cgImage: result))
        }
        return cropResults
    }
    func loadImages() -> [UIImage] {
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let urls = (0...2).map { index in
            return cachesDirectory.appendingPathComponent("\(index).jpg")
        }
        let data = urls.compactMap { url in
            return try? Data(contentsOf: url)
        }
        let images = data.map { item in
            return UIImage(data: item)!
        }
        return images
    }
    func createBody(boundary: String) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let urls = (0...2).map { index in
            return cachesDirectory.appendingPathComponent("\(index).jpg")
        }
        let data = urls.compactMap { url in
            return try? Data(contentsOf: url)
        }
        (0...2).forEach { index in
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\("img_" + String(index + 1))\"; filename=\"\(String(index) + ".jpg")\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(data[index])
            body.append("\r\n".data(using: .utf8)!)
        }
        body.append(boundaryPrefix.data(using: .utf8)!)
        return body
    }
    func sendRequest(uiImages: [UIImage]) {
        let endPoint = URL(string: Constants.ocrEndPoint)!
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
            print("Request sent.")
            DispatchQueue.main.async {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else {
                        print("JSON Serialization failed.")
                        return
                    }
                    print("Responded with...")
                    print(jsonObject)
                    let results = jsonObject["result"]! as! [String]
                    withAnimation {
                        Camera.shared.results = results
                        Camera.shared.id = UUID()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

struct Preview: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return Camera.shared.getPreview()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // TODO: NOTHING TO DO.
    }
}
