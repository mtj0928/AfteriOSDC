//
//  ImpressionSlide2.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/13.
//

import SlideKit
import SwiftUI

struct ImpressionSlide2: Slide {

    enum State: Int, PhasedState {
        case initial, foundation, pdf
    }

    @Phase var phasedStateStore: PhasedStateStore<State>

    var body: some View {
        HeaderSlide("スライドをSwiftUIで作ってみた感想") {
            Item("悪かった点", accessory: nil) {
                Item("油断するとうっかりscaleのことを忘れてしまう") {
                    Item("正直これはもっと良い方法がありそう")
                }
                if phasedStateStore.after(.foundation) {
                    Item("ある程度土台ができるまで、できないことが多くて辛かった(なんならまだ多い)")
                }
                if phasedStateStore.after(.pdf) {
                    Item("PDFにする機能とかもあるけど、文字情報が無くて検索がかけられない")
                }
            }
        }
    }
}

struct ImpressionSlide2_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ImpressionSlide2()
        }
    }
}
