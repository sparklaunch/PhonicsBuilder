//
//  RootView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI

struct RootView: View {
    @State private var modalShown = false
    var body: some View {
        ZStack {
            Preview()
                .rotationEffect(.degrees(-90))
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            Camera.verifyPermissions()
        }
        .onTapGesture {
            Camera.capturePhoto()
            modalShown = true
        }
        .sheet(isPresented: $modalShown) {
            let uiImage = Camera.loadPhoto()!
            let croppedPhoto = Camera.cropPhoto(uiImage)
            let image = Image(uiImage: croppedPhoto)
            image
                .resizable()
                .rotationEffect(.degrees(-90))
                .scaledToFit()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
