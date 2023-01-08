//
//  Camera.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI
import AVKit

class Camera: NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    func requestAndCheckPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                    if authStatus {
                        DispatchQueue.main.async {
                            self?.setUpCamera()
                        }
                    }
                }
            case .restricted:
                break
            case .authorized:
                setUpCamera()
            default:
                print("Permission denied")
        }
    }
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            do {
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning()
            } catch {
                print(error)
            }
        }
    }
    func capturePhoto() {
        let photoSettings = AVCapturePhotoSettings()
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("Photo's taken.")
    }
    func savePhoto(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("Photo's saved.")
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        self.savePhoto(imageData)
        print("Capture routine's done.")
    }
}
