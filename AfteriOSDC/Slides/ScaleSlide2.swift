//
//  ScaleSlide2.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/11.
//

import SlideKit
import SwiftUI

struct ScaleSlide2: Slide {
    enum SlidePhasedState: Int, PhasedState {
        case initial, code, itemize
    }

    @Phase var phasedStateStore: PhasedStateStore<SlidePhasedState>

    var body: some View {
        HeaderSlide("解決策 + α") {
            Text("スライド作成でよく使うものついてはラップしたViewやViewModifierを用意")
            if phasedStateStore.when(.itemize) {
                Item("View", accessory: nil) {
                    SlideVStack(alignment: .leading) {
                        Item("SlideVStack")
                        Item("SlideHStack")
                    }
                }
                Item("ViewModifier", accessory: nil) {
                    SlideHStack(spacing: 54) {
                        SlideVStack(alignment: .leading) {
                            Item("slideFontSize")
                            Item("slideFrame")
                        }
                        SlideVStack(alignment: .leading) {
                            Item("slidePadding")
                            Item("slideOffset")
                        }
                    }
                }
            } else if phasedStateStore.when(.code) {
                Code(code, fontSize: .code)
            }
        }
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                そこで解決策+アルファです。
                スライド作成でよく使うものについて、さっきのslidescaleの処理をラップしたViewやViewModiferを独自で用意しました。
                """
        case .code:
            return """
                こんな感じで、SlideHStackみたいなものを用意しました。
                同様にslideFrameやslideFontSizeも用意しました。
                slideFontSizeを見てみると50という値だけを渡しています。
                これは内部でscaleをしているので呼び出す側は単に50という値を渡すだけですみます。
                """
        case .itemize:
            return """
                今見たもの以外にもSlideVStackやslidePadding、slideOffsetみたいに色々用意しました。
                正直かなり力技でスマートな方法ではないですが、これで今回は解決しました。
                """
        }
    }
}

private let code = """
struct SampleSlide: Slide {

    var body: some View {
        SlideHStack {
            Circle()
                .slideFrame(width: 30)
            Text("Hoge")
                .slideFontSize(50)
        }
    }
}
"""

struct ScaleSlide2_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ScaleSlide2()
        }
    }
}
