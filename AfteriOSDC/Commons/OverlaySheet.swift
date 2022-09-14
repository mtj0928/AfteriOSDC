//
//  OverlaySheet.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/10.
//

import SlideKit
import SwiftUI

struct OverlaySheet: View {

    var topHeight: CGFloat
    var height: CGFloat = 50

    var body: some View {
        SlideVStack(spacing: .zero) {
            Color.white
                .slideFrame(height: topHeight)
            Rectangle()
                .opacity(0.0)
                .slideFrame(height: height)
            Color.white
        }
        .opacity(0.8)
    }
}
