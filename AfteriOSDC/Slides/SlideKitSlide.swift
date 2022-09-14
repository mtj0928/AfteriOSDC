//
//  SlideKitSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/13.
//

import SlideKit
import SwiftUI

struct SlideKitSlide: Slide {
    var body: some View {
        SlideVStack(spacing: 32) {
            Text("SlideKit")
                .fontWeight(.bold)
                .slideFontSize(120)
                .slideLineSpace(30)
            Text("https://github.com/mtj0928/SlideKit")
                .slideFontSize(38)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .multilineTextAlignment(.center)
        .allowsHitTesting(false)
    }
}

struct SlideKitSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SlideKitSlide()
        }
    }
}
