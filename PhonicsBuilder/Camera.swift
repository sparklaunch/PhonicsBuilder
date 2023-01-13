import SwiftUI
import AVFoundation

class Camera: ObservableObject {
    @Published public var results: [String] = []
    @Published public var iconsShown = false
    public static let shared = Camera()
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
            let croppedPhotos = Camera.cropPhoto(rotatedUIImage)
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
            let uiImages = Camera.loadImages()
            Camera.sendRequest(uiImages: uiImages)
        }
    }
    static let pixelFormatType = kCVPixelFormatType_32BGRA
    static let captureProcessor = PhotoCaptureProcessor()
    static let photoOutput = AVCapturePhotoOutput()
    static let previewView = PreviewView()
    static let captureSession = AVCaptureSession()
    static let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    static func verifyPermissions() {
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
    static func requestVideoPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                prepareCapture()
                finishCapture()
                startSession()
            }
        }
    }
    static func prepareCapture() {
        captureSession.beginConfiguration()
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else {
            print("Initializing videoDeviceInput failed.")
            return
        }
        captureSession.addInput(videoDeviceInput)
    }
    static func finishCapture() {
        guard captureSession.canAddOutput(photoOutput) else {
            print("Adding photoOutput failed.")
            return
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
    }
    static func getPreview() -> UIView {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.connection?.videoOrientation = .landscapeLeft
        previewView.videoPreviewLayer.session = captureSession
        return previewView
    }
    static func startSession() {
        captureSession.startRunning()
    }
    static func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings(format: [kCVPixelBufferPixelFormatTypeKey as String: pixelFormatType])
        photoOutput.capturePhoto(with: photoSettings, delegate: captureProcessor)
        print("Photo captured.")
    }
    static func loadPhoto() -> UIImage? {
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
    static func cropPhoto(_ uiImage: UIImage) -> [UIImage] {
        let width = uiImage.size.width
        let height = uiImage.size.height
        let firstCropRect = CGRect(x: 0, y: height * 0.2, width: width * 0.33, height: height * 0.6)
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
    static func loadImages() -> [UIImage] {
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
    static func createBody(boundary: String) -> Data {
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
    static func sendRequest(uiImages: [UIImage]) {
        let endPoint = URL(string: "http://3.38.222.142/ocr")!
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
                    Camera.shared.results = results
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
        return Camera.getPreview()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // TODO: NOTHING TO DO.
    }
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x, width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            return rotatedImage ?? self
        }
        return self
    }
}
