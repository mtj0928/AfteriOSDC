//
//  SlideItem.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/07.
//

import SwiftUI
import SlideKit

struct SlideItem: View {

    let number: Int
    let text: String
    let opacity: CGFloat

    init(_ number: Int, text: String, opacity: CGFloat = 1.0) {
        self.number = number
        self.text = text
        self.opacity = opacity
    }

    var body: some View {
        SlideHStack(spacing: 32) {
            Text("\(number)")
                .slidePadding()
                .slideFrame(width: 80)
                .foregroundColor(.white)
                .background(Color.accentColor.opacity(opacity))
                .clipShape(Circle())
            Text(text)
                .opacity(opacity)
        }
    }
}
