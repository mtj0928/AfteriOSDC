//
//  PremiseSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/06.
//

import SwiftUI
import SlideKit

struct PremiseSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, two, overlay
    }

    @Phase var phasedStateStore

    @Environment(\.slideScale)
    var slideScale

    var body: some View {
        HeaderSlide("前提条件") {
            SlideItem(1, text: "通知のデモをするためにiPhone / iPadOSで動作する (macOSはオプション)")
            if phasedStateStore.after(.two) {
                SlideItem(2, text: "iPhoneを繋いだ外部ディスプレイのサイズに最適化する")
            }
        }
        .overlay {
            if phasedStateStore.when(.overlay) {
                ZStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.gray)
                        RoundedRectangle(cornerRadius: slideScale * 30)
                            .slideOffset(x: -270, y: -70)
                            .slideFrame(width: 1300, height: 150)
                            .foregroundColor(.black)
                    }
                    .compositingGroup()
                    .luminanceToAlpha()

                    Group {
                        Text("これが全てを難しくする")
                            .fontWeight(.bold)
                            .slideFontSize(50)
                            .slidePadding()
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .slideCornerRadius(10)
                            .slideOffset(y: 100)
                        Path { path in
                            path.move(to: .init(x: slideScale * DesignGuide.triangleSize / 2, y: 0))
                            path.addLine(to: CGPoint(x: 0, y: slideScale * DesignGuide.triangleSize))
                            path.addLine(to: CGPoint(x: slideScale * DesignGuide.triangleSize, y: slideScale * DesignGuide.triangleSize))
                            path.addLine(to: CGPoint(x: slideScale * DesignGuide.triangleSize / 2, y: 0))
                        }
                        .fill(Color.accentColor)
                        .slideFrame(width: 100, height: 100)
                        .slideOffset(x: -170, y: 50)
                    }
                    .slideOffset(x: -100, y: -10)
                }
            }
        }
        .allowsHitTesting(false)
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                今回のスライドアプリを作る上で、いくつかの前提となる仕様がありました。
                まず一つ目に、通知のデモをしたかったのでiPhoneで動くという点です。
                macOSで動くことはOptionにしたのですが、結果的には動きました。
                """
        case .two:
            return """
                2つ目に外部ディスプレイのサイズに最適化した状態でスライドを表示するという仕様です。

                """
        case .overlay:
            return "これがかなり難しかったです"
        }
    }

    private enum DesignGuide {
        static let triangleSize: CGFloat = 50
    }
}

struct PremiseSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            PremiseSlide()
        }
    }
}
