//
//  HardPointSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/06.
//

import SwiftUI
import SlideKit

struct HardPointSlide: Slide {
    var highlight: Int? = nil

    var body: some View {
        HeaderSlide("外部ディスプレイの課題") {
            item(1, text: "外部ディスプレイの切り替え")
            item(2, text: "外部ディスプレイのスライドと発表者のスライドが別のView")
            item(3, text: "外部ディスプレイのサイズが未知")
        }
    }

    private func item(_ number: Int, text: String) -> some View {
        SlideItem(
            number,
            text: text,
            opacity: highlight == nil || highlight == number ? 1.0 : 0.4
        )
    }
}

struct HardPointSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            HardPointSlide()
        }
    }
}
