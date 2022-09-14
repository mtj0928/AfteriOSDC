//
//  ScaleSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/11.
//

import SlideKit
import SwiftUI

struct ScaleSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, scale, fontAndFrame, hstack
    }

    @Phase var phasedStateStore: PhasedStateStore<SlidePhasedState>

    var body: some View {
        HeaderSlide("解決策") {
            Text("Environmentでスライドのスケールを取得し、全てのレイアウトを変換する")
            Code(code, fontSize: .code)
                .overlay {
                    if phasedStateStore.when(.scale) {
                        OverlaySheet(topHeight: 80)
                        CodeCaption(text: "スライドのスケールを取得できる")
                            .slideOffset(y: -80)
                    }
                }
                .overlay {
                    if phasedStateStore.when(.fontAndFrame) {
                        OverlaySheet(topHeight: 235, height: 153)
                        CodeCaption(text: "スケールをかけた値を渡す")
                            .slideOffset(x: 300, y: 200)
                    }
                }
                .overlay {
                    if phasedStateStore.when(.hstack) {
                        OverlaySheet(topHeight: 192, height: 40)
                        CodeCaption(text: "HStackのspacingを忘れない")
                            .slideOffset(x: 100, y: 40)
                    }
                }
        }
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                ではどう解決したの説明します。
                Environmentでスライドのスケールを取得し、全てのレイアウトを変換しています。
                """
        case .scale:
            return """
                こんな感じで、新しいSlideScaleというEnvironmentを追加しました。
                この値は、本来のスライドのサイズ、1920x1080と比べて、今の画面は何倍か、という情報が入っています。
                """
        case .fontAndFrame:
            return """
                そしてこの値を使って、frameやfontSizeを設定しています。
                Keynoteとかで50ptのフォントを使いたかったら、このように50にsldeScaleをかけるといった感じです。
                """
        case .hstack:
            return """
                ただこれ、罠があります。
                そうです、HStackやVStackのspacingです。
                HStackのspacingにはデフォルト値として16が入っているのですが、それはもちろん絶対的な値であって相対的な値ではありません。
                なので、HStackやVStackを呼び出すときにも毎回こうspaingの設定が必要です。
                ただ正直これはかなりきついですよね
                """
        }
    }
}

private let code = """
struct SampleSlide: Slide {

    @Environment(\\.slideScale) var slideScale

    var body: some View {
        HStack(spacing: slideScale * 16) {
            Circle()
                .frame(width: slideScale * 30)
            Text("Hoge")
                .font(.system(size: slideScale * 50))
        }
    }
}
"""

struct ScaleSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ScaleSlide()
        }
    }
}
