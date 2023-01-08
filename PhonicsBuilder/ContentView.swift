//
//  ContentView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    var body: some View {
        ZStack {
            Text("Hello World")
                .zIndex(0)
            if isLoading {
                splashScreenView.transition(.opacity).zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    isLoading.toggle()
                }
            })
        }
    }
}

extension ContentView {
    var splashScreenView: some View {
        ZStack {
            Image("Splash")
                .resizable()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
