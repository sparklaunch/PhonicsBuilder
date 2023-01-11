//
//  PhonicsBuilderApp.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/09.
//

import SwiftUI

@main
struct PhonicsBuilderApp: App {
    @StateObject private var camera = Camera.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(camera)
        }
    }
}
