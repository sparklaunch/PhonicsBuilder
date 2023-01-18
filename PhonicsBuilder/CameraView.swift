//
//  CameraView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/18.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
        VStack {
            LottieView(jsonName: "Camera")
                .frame(width: 100, height: 100)
                .background(
                    Circle()
                        .foregroundColor(.white.opacity(0.8))
                )
                .padding()
            Spacer()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
