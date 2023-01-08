//
//  CameraView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var viewModel: CameraViewModel
    var body: some View {
        ZStack {
            viewModel.cameraPreview
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.configure()
                }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(viewModel: CameraViewModel())
    }
}
