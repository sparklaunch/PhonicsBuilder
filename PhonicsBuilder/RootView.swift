//
//  RootView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var camera: Camera
    var body: some View {
        ZStack {
            Preview()
                .rotationEffect(.degrees(-90))
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Text(camera.results.isEmpty ? "No Input" : camera.results.joined(separator: ", "))
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .onAppear {
            Camera.verifyPermissions()
        }
        .onTapGesture {
            Camera.capturePhoto()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(Camera())
    }
}
