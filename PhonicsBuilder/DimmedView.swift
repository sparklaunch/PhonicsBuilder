//
//  DimmedView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/12.
//

import SwiftUI

struct DimmedView: View {
    let height: Double
    var body: some View {
        Rectangle()
            .foregroundColor(.black.opacity(0.5))
            .frame(height: height * 0.2)
    }
}
