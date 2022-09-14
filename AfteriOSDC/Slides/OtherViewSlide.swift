//
//  OtherViewSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import SlideKit
import SwiftUI

struct OtherViewSlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, red, blue, green
    }

    @Environment(\.slideScale)
    var slideScale

    @Phase
    var phasedStateStore

    var body: some View {
        HeaderSlide("Viewの同期") {
            SlideHStack(spacing: 24) {
                SlideVStack(spacing: 24) {
                    Image("iPhone")
                        .resizable()
                        .scaledToFit()
                        .slideFrame(width: DesignGuide.iPhoneSize)
                        .background {
                            deviceBackground(radius: 50, delay: 0.0)
                        }
                    Text("iPhone")
                        .slideFontSize(.caption)
                }

                Arrow(from: .leading, to: .trailing, arrowAngle: 180, arrowLength: slideScale * 35)
                    .stroke(style: .init(lineWidth: 2, lineCap: .round))
                    .overlay {
                        Text("反映")
                            .slideOffset(y: -50)
                            .slideFontSize(.caption)
                    }

                SlideVStack(spacing: 24) {
                    RoundedRectangle(cornerRadius: slideScale * 10)
                        .stroke(style: .init(lineWidth: slideScale * 4))
                        .slideFrame(width: DesignGuide.displaySize * 16 / 9, height: DesignGuide.displaySize)
                        .background { deviceBackground(radius: 10, delay: 0.3) }
                    Text("外部ディスプレイ")
                        .slideFontSize(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .slidePadding(.horizontal, 140)
            .frame(maxHeight: .infinity, alignment: .center)
            .animation(.default, value: phasedStateStore.current)
        }
    }

    private func deviceBackground(radius: CGFloat, delay: Double) -> some View {
        ZStack {
            Group {
                if phasedStateStore.after(.red) {
                    Color.red
                        .slideCornerRadius(radius)
                        .transition(.circle.animation(.default.delay(delay)))
                        .zIndex(1)
                }
                if phasedStateStore.after(.blue) {
                    Color.blue
                        .slideCornerRadius(radius)
                        .transition(.circle.animation(.default.delay(delay)))
                        .zIndex(2)
                }
                if phasedStateStore.after(.green) {
                    Color.green
                        .slideCornerRadius(radius)
                        .transition(.circle.animation(.default.delay(delay)))
                        .zIndex(2)
                }
            }
        }
        .transition(.circle.animation(.default.delay(delay)))
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                こんな感じでiPhoneの画面が外部ディスプレイに反映されています。
                繰り返しになりますが、同じ画面をしていてもこれらは実際は別のViewです。
                なので
                """
        case .red:
            return """
                こんな感じでiPhoneの画面が変わったら、それを外部ディスプレイにも伝える必要があります。
                """
        case .blue: return "iPhoneの画面が青になったら、外部ディスプレイも青にし、"
        case .green:
            return """
                iPhoneの画面が緑になったら外部ディスプレイも緑にする必要があります。
                そしてここで罠があります。
                """
        }
    }

    enum DesignGuide {
        static let displaySize: CGFloat = 450
        static let iPhoneSize: CGFloat = 250
    }
}

struct iPhoneShape: Shape {

    let scale: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addPath(RoundedRectangle(cornerRadius: 20 * scale).path(in: rect))
            path.addPath(RoundedRectangle(cornerRadius: 10 * scale).path(in:
                    .init(x: rect.width * 0.3, y: -rect.height * 0.1, width: rect.width * 0.4, height: rect.height * 0.2)))
        }
    }
}

struct OtherViewSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            OtherViewSlide()
        }
    }
}
