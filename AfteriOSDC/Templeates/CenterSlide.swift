//
//  CenterSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/06.
//

import SwiftUI
import SlideKit

struct CenterSlide<Title>: Slide where Title: View {

    let title: () -> Title

    init(_ text: String) where Title == Text{
        self.title = {
            Text(text)
                .bold()
        }
    }

    init(_ title: @escaping () -> Title) {
        self.title = title
    }

    var body: some View {
        title()
            .slideFontSize(80)
            .slideLineSpace(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .allowsHitTesting(false)
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            CenterSlide("デモのために外部ディスプレイと\nミラーリングを切り替える必要があった")
        }
    }
}
