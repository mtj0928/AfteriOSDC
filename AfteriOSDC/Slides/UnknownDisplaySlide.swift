//
//  UnknownDisplaySlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/11.
//

import SlideKit
import SwiftUI

struct UnknownDisplaySlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, message
    }

    @Phase var phasedStateStore: PhasedStateStore<SlidePhasedState>

    var body: some View {
        HeaderSlide("ディスプレイのサイズがわからない") {
            Item("ディスプレイのサイズに限らず、スライドのレイアウトが崩れてはならない")
            Item("ディスプレイのサイズが変われば、フォントサイズ等を更新する必要がある")

            Spacer()
            if phasedStateStore.when(.message) {
                Text("フォントサイズやレイアウトは全て\n絶対的な値ではなく相対的な値を指定する必要がある")
                    .fontWeight(.bold)
                    .slideFontSize(.subHeadline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .slidePadding()
                    .background(Color.accentColor)
                    .slideCornerRadius(20)
                    .slidePadding(.bottom, 60)
            }
        }
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                当日どんなサイズのディスプレイで発表をするのかわかりませんでした。
                しかし、ディスプレイのサイズに限らず、スライドのレイアウトが崩れてはいけません。
                ディスプレイのサイズが変われば、フォントサイズやレイアウトも更新する必要があります。
                こう言ってもわかりにくいので、ちょっと画面全体を共有します。
                (画面共有して、ウインドウのサイズを変える)
                もしかすると何も違和感を感じない挙動化かもしれません。
                ただ、これ結構変なことをしていて、ウインドウのサイズに合わせて、文字のサイズも変わっています。
                (画面共有戻す)
                """
        case .message:
            return """
                これを実現するにはSwiftUIのViewに渡すレイアウトの情報を全て絶対的な値ではなくて、相対的な値にする必要があります。
                """
        }
    }
}

struct UnknownDisplaySlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            UnknownDisplaySlide()
        }
    }
}
