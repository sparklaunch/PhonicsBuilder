//
//  Camera.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI
import AVFoundation

enum Camera {
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
            guard error == nil else {
                print("Error capturing photo: \(error!)")
                return
            }
            guard let photoData = photo.fileDataRepresentation() else {
                return
            }
            guard let uiImage = UIImage(data: photoData) else {
                print("Unable to generate UIImage from image data.")
                return
            }
            guard let jpegData = uiImage.jpegData(compressionQuality: 100) else {
                return
            }
            let fileManager = FileManager.default
            let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let imageURL = url.appendingPathComponent("image.jpg")
            let imagePath = imageURL.path
            fileManager.createFile(atPath: imagePath, contents: jpegData)
        }
    }
    static let pixelFormatType = kCVPixelFormatType_32BGRA
    static let captureProcessor = PhotoCaptureProcessor()
    static let photoOutput = AVCapturePhotoOutput()
    static let previewView = PreviewView()
    static let captureSession = AVCaptureSession()
    static let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    static let photoSettings = AVCapturePhotoSettings(format: [kCVPixelBufferPixelFormatTypeKey as String: pixelFormatType])
    static func verifyPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                prepareCapture()
                finishCapture()
                startSession()
            case .notDetermined:
                requestVideoPermission()
            case .denied:
                return
            case .restricted:
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
            return
        }
        captureSession.addInput(videoDeviceInput)
    }
    static func finishCapture() {
        guard captureSession.canAddOutput(photoOutput) else {
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
        photoOutput.capturePhoto(with: photoSettings, delegate: captureProcessor)
    }
    static func loadPhoto() -> UIImage? {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let photoURL = url.appendingPathComponent("image.jpg")
        let photoPath = photoURL.path
        guard fileManager.fileExists(atPath: photoPath) else {
            return nil
        }
        guard let data = try? Data(contentsOf: photoURL) else {
            return nil
        }
        guard let uiImage = UIImage(data: data) else {
            return nil
        }
        return uiImage
    }
    static func cropPhoto(_ uiImage: UIImage) -> UIImage {
        let cropRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let croppedImage = uiImage.cgImage!.cropping(to: cropRect)
        return UIImage(cgImage: croppedImage!)
    }
}

struct Preview: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return Camera.getPreview()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
