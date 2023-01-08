//
//  CameraViewModel.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI
import AVKit

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    let cameraPreview: AnyView
    func configure() {
        model.requestAndCheckPermissions()
    }
    func capturePhoto() {
        model.capturePhoto()
        print("Photo captured.")
    }
    init() {
        model = Camera()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
    }
}
