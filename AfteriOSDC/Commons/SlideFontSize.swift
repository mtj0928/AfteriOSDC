//
//  SlideFontSize.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/01.
//

import SlideKit
import SwiftUI

enum SlideFontSize: CGFloat {
    case largeTitle =  80
    case subHeadline = 60
    case body = 48
    case callout = 36
    case code = 32
    case caption = 28
}

extension Text {
    func slideFontSize(_ size: SlideFontSize, scale: CGFloat) -> Text {
        self.font(.system(size: scale * size.rawValue))
    }

    func slideFontSize(_ size: CGFloat, scale: CGFloat) -> Text {
        self.font(.system(size: scale * size))
    }
}

extension View {
    func slideFontSize(_ size: SlideFontSize) -> some View {
        slideFontSize(size.rawValue)
    }
}

extension Code {
    init (_ code: String, fontSize: SlideFontSize = .code) {
        self.init(code, slideFontSize: fontSize.rawValue)
    }
}
