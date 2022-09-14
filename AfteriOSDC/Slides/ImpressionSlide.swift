//
//  ImpressionSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/13.
//

import SlideKit
import SwiftUI

struct ImpressionSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, smooth, reuse, syntax
    }

    @Phase var phasedStateStore: PhasedStateStore<SlidePhasedState>

    var body: some View {
        HeaderSlide("スライドをSwiftUIで作ってみた感想") {
            Item("良かった点", accessory: nil) {
                Item("全てをコントロールできる全能感") {
                    Item("その気になればなんでも実装できる (スライドにTweetを出すとか)")
                }
                if phasedStateStore.after(.smooth) {
                    Item("慣れると思った以上にスムーズにスライドが作れる")
                }
                if phasedStateStore.after(.reuse) {
                    Item("スライドの再利用性が上がり、メンテがしやすい")
                }
                if phasedStateStore.after(.syntax) {
                    Item("(スライドでは省略したけど) コードのシンタックスハイライトとかが\n自動でつくのも便利")
                }
            }
        }
    }
}

struct ImpressionSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ImpressionSlide()
        }
    }
}
