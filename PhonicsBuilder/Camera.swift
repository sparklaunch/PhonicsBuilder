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
    static let previewView = PreviewView()
    static let captureSession = AVCaptureSession()
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
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else {
            return
        }
        captureSession.addInput(videoDeviceInput)
    }
    static func finishCapture() {
        let photoOutput = AVCapturePhotoOutput()
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
}

struct Preview: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return Camera.getPreview()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
