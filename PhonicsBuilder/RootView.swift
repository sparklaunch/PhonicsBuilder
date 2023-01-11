//
//  RootView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI

struct RootView: View {
    @State private var modalShown = false
    @State private var modalReallyShown = false
    @State private var images: [Image] = []
    var body: some View {
        ZStack {
            Preview()
                .rotationEffect(.degrees(-90))
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Button {
                modalShown = true
            } label: {
                Text("See cropped images")
            }
        }
        .onAppear {
            Camera.verifyPermissions()
        }
        .onTapGesture {
            Camera.capturePhoto()
        }
        .onChange(of: modalShown) { newValue in
            if modalShown {
                let uiImages = Camera.loadImages()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
