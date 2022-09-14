//
//  CenterSlideItem.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import SwiftUI
import SlideKit

struct CenterSlideItem: View {

    let number: Int
    let text: String

    init(_ number: Int, text: String) {
        self.number = number
        self.text = text
    }

    var body: some View {
        SlideHStack(spacing: 32) {
            Text("\(number)")
                .slidePadding()
                .slideFrame(width: 120)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .clipShape(Circle())
            Text(text)
                .bold()
        }
    }
}
