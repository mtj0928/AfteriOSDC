//
//  ExternalDisplayIntroductionSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/08.
//

import SlideKit
import SwiftUI

struct ExternalDisplayIntroductionSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, mirroring, external1, external2
    }

    @Environment(\.slideScale)
    var slideScale

    @Phase
    var phasedStateStore

    var body: some View {
        HeaderSlide("「外部ディスプレイに最適化」とは？") {
            SlideHStack(spacing: 32) {
                item(name: "ミラーリング") {
                    ZStack {
                        Color.clear
                        if phasedStateStore.after(.mirroring) {
                            Rectangle()
                                .foregroundColor(.orange)
                                .transition(.circle)
                                .layoutPriority(-1)
                            SlideVStack {
                                Text("←   端が余る   →")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .slideFontSize(60)
                                Text("(iPhoneと同じ画面)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .slideFontSize(40)
                            }
                            Text("09:41")
                                .fontWeight(.bold)
                                .slideFontSize(20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .slidePadding(8)
                            Capsule()
                                .slideFrame(width: 70, height: 10)
                                .slidePadding(16)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }
                    .slidePadding(.horizontal, 60)
                }
                if phasedStateStore.after(.external1) {
                    item(name: "外部ディスプレイに最適化") {
                        ZStack {
                            if phasedStateStore.after(.external2) {
                                Rectangle()
                                    .foregroundColor(.accentColor)
                                    .transition(.circle)
                                SlideVStack {
                                    Text("←   端までみっちり   →")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .slideFontSize(60)
                                    Text("(iPhoneと違う画面)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .slideFontSize(40)
                                }
                            }
                        }
                    }
                }
            }
        }
        .animation(.default, value: phasedStateStore.current)
    }

    func item(name: String, contents: @escaping () -> some View) -> some View {
        SlideVStack {
            Rectangle()
                .foregroundColor(.clear)
                .overlay {
                    SlideVStack(spacing: 24) {
                        RoundedRectangle(cornerRadius: slideScale * 10)
                            .stroke(style: .init(lineWidth: slideScale * 2))
                            .slideFrame(width: DesignGuide.displaySize * 16 / 9, height: DesignGuide.displaySize)
                            .background {
                                contents()
                            }
                            .cornerRadius(slideScale * 10)
                        Text("外部ディスプレイ")
                            .slideFontSize(.caption)
                    }
                }
            Text(name)
                .fontWeight(.semibold)
        }
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                そもそも外部ディスプレイに最適化ってどいういことでしょうか？
                まずはミラーリングの場合に説明します。
                """
        case .mirroring:
            return """
                こんな感じですね。
                端が余っていたり、右上に時間がででいたり、画面の下の方にバーがででいたりしています。
                """
        case .external1:
            return """
                一方で、外部ディスプレイに最適化している場合を見てみましょう。
                """
        case .external2:
            return """
                画面の端までみっちり表示されています。
                時間も出てないですし、バーも表示されていません。
                """
        }
    }

    enum DesignGuide {
        static let displaySize: CGFloat = 420
    }
}

struct ExternalDisplayIntroductionSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            ExternalDisplayIntroductionSlide()
        }
    }
}

extension AnyTransition {
    static var circle: AnyTransition {
        AnyTransition.modifier(
            active: CircleScaleModifier(isFull: false),
            identity: CircleScaleModifier(isFull: true))
    }
}

private struct CircleScaleModifier: ViewModifier {

    let isFull: Bool

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            let dx = proxy.size.width
            let dy = proxy.size.height
            let distance = sqrt(dx * dx + dy * dy)
            let scale = distance / min(proxy.size.width, proxy.size.height)
            content
                .clipShape(Rectangle().path(in: proxy.frame(in: .local)))
                .clipShape(Circle()
                    .scale(isFull ? scale : 0.0)
                )
        }
    }
}
