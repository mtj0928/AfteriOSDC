//
//  TitleSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/01.
//

import SlideKit
import SwiftUI

struct TitleSlide: Slide {

    @Environment(\.slideScale)
    var scale

    var body: some View {
        SlideVStack(alignment: .center, spacing: 24) {
            Spacer(minLength: 0)
            SlideVStack(alignment: .leading, spacing: 24) {
                titleText
                    .fontWeight(.heavy)
                    .lineLimit(2)
                    .slideFontSize(.largeTitle)
                Text("まつじ (@mtj_j)")
                    .fontWeight(.bold)
                    .slideFontSize(.body)
            }
            .slidePadding(80)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            Spacer(minLength: 0)
        }
        .overlay {
            Text("（このスライドもSwiftUIで書かれています）")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .slideFontSize(38)
                .slidePadding(.leading, 80)
                .slidePadding(.bottom)
        }
    }

    var titleText: Text {
        Text("iOSDC")
            .slideFontSize(90, scale: scale)
        + Text(" の ")
            .slideFontSize(70, scale: scale)
        + Text("発表スライド")
            .slideFontSize(90, scale: scale)
        + Text(" を \n")
            .slideFontSize(70, scale: scale)
        + Text("SwiftUI")
            .slideFontSize(180, scale: scale)
            .foregroundColor(.accentColor)
        + Text(" で ")
            .slideFontSize(70, scale: scale)
        + Text("作った話")
            .slideFontSize(90, scale: scale)
    }

    let shouldHideIndex = true

    var script: String {
        "それではiOSDCの発表スライドをSwiftUIで作った話をします。ちなみに、このスライドもSwiftUIで作ってます。"
    }
}

struct TitleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview(slideSize: SlideSize.standard16_9) {
            TitleSlide()
        }
    }
}
