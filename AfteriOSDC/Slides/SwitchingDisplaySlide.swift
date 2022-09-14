//
//  SwitchingDisplaySlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import SlideKit
import SwiftUI

struct SwitchingDisplaySlide: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, presentation
    }

    @Phase var phasedStateStore

    var body: some View {
        HeaderSlide("外部ディスプレイの切り替え") {
            Text(
                phasedStateStore.when(.initial) ?
                "最適化 → ミラーリング" : "ミラーリング → 最適化")
                .fontWeight(.semibold)
            Code(
                phasedStateStore.when(.initial) ? mirroringCode : presentationCode,
                fontSize: .code
            )
        }
    }

    private var mirroringCode: String {
"""
extension SceneDelegate {
    func startMirroring() {
        let sessionRole = self.window?.windowScene?.session.role
        guard sessionRole == .windowExternalDisplayNonInteractive else {
            return
        }
        // なんとnilにするだけ
        window = nil
    }
}
"""
    }

    private var presentationCode: String {
"""
extension SceneDelegate {
    func startPresentation(windowScene: UIWindowScene) {
        guard windowScene.session.role == .windowExternalDisplayNonInteractive else {
            return
        }
        // なんと新規Windowを作るだけ
        window = makeRootWindow()
        window.makeKeyAndVisible()
    }
}
"""
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                さて、どうやって切り替えるかですが、まずは外部ディスプレイに最適化されている状態からミラーリングに切り替える方法を説明します。
                実は結構簡単にできます。
                session roleがwindowExternalDisplayNonInteractiveのsceneDelegateのwindowにnilを入れて、キャプチャーされているwindowを解放するだけです。
                これだけで、ミラーリングに切り替えることができます。
                """
        case .presentation:
            return """
                次にミラーリングの状態から外部ディスプレイに戻す方法です。
                これはさっきの逆をしてあげれば大丈夫です。
                つまりSceneDelegateのwindowにUIWindowを新しく設定してあげれば大丈夫です。
                この仕組みに気づくのにかなり時間がかかってしまいました。
                """
        }
    }
}

struct SwitchingDisplaySlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SwitchingDisplaySlide()
        }
    }
}
