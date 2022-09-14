//
//  SlideConfiguration.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/08.
//

import SwiftUI
import SlideKit

struct SlideConfiguration {

    let size = SlideSize.standard16_9

    let slideIndexController = SlideIndexController {
        TitleSlide()
        SelfIntroductionSlide()
        CenterSlide("iOSDCの発表スライドを作り始める時の僕🦌")
        CenterSlide("「発表スライド、SwiftUIで作ってみるか🤔」")
        CenterSlide("理由 : 面白そう😎")
        CenterSlide("これが地獄の始まりでした😱")
        PremiseSlide()
        ExternalDisplayIntroductionSlide()
        SupportExternalDisplay()
        HardPointSlide()
        HardPointSlide(highlight: 1)
        CenterSlide("ネットに一切の情報がなかった😥")
        CenterSlide("しかし、標準の写真アプリはできている🤔")
        CenterSlide("何か方法があるはず😤\n(Appleがズルしてなければ)")
        CenterSlide("手探りで色々試したらできてしまった😎")
        SwitchingDisplaySlide()
        HardPointSlide(highlight: 2)
        CenterSlide("Viewが別とは🤔")
        CenterSlide("iPhoneと外部ディスプレイは\n同じデザインを表示していても実際は別のView🧐")
        CenterSlide("Viewの同期が必要😩")
        OtherViewSlide()
        CenterSlide("複数のViewで状態を同期する必要があり\n@Stateとかが使えない😩")
        SharedObjectSlide1()
        SharedObjectSlide2()
        HardPointSlide(highlight: 3)
        CenterSlide("これが一番辛かったハードル☠️")
        CenterSlide("外部ディスプレイのサイズがわからん🤯")
        UnknownDisplaySlide()
        ScaleSlide()
        ScaleSlide2()
        CenterSlide("これでプレゼンスライドを作れるようになりました🎉")
        ImpressionSlide()
        ImpressionSlide2()
        CenterSlide("しかし、今後スライドを作る時は\nSwiftUIで作るのもアリだと思いました")
        CenterSlide("ということで...")
        CenterSlide("ライブラリ化しました🥳")
        SlideKitSlide()
        CenterSlide("まだまだ紹介できていない機能があります💪")
        CenterSlide("しかしこれについて話す時間はもうないので\nそのうちブログに書きます")
        CenterSlide("最後にこの発表のまとめスライドをDemoします")
    }
}

struct Slide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview(index: 34) {
            return SlideConfiguration().slideIndexController.slides
        }
    }
}
