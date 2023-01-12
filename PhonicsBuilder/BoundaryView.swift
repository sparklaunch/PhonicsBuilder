//
//  BoundaryView.swift
//  PhonicsBuilder
//
//  Created by 신정훈 on 2023/01/12.
//

import SwiftUI

struct BoundaryView: View {
    let height: Double
    var body: some View {
        Rectangle()
            .strokeBorder(Color("MainColor"), lineWidth: 10)
            .frame(height: height * 0.6)
    }
}
