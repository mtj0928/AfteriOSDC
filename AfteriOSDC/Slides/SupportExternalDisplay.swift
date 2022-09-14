//
//  SupportExternalDisplay.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/09.
//

import SlideKit
import SwiftUI

struct SupportExternalDisplay: Slide {

    @Environment(\.slideScale)
    var scale

    var body: some View {
        HeaderSlide("外部ディスプレイの実装方法") {
            SlideVStack(alignment: .leading, spacing: 24) {
                SlideItem(1, text: "Info.plistに設定を追加 (省略)")
                SlideVStack(alignment: .leading, spacing: 36) {
                    SlideItem(2, text: "SceneDelegateで外部ディスプレイ用のwindowを用意")
                    Code(code, fontSize: .code)
                        .slidePadding()
                        .slidePadding(.leading)
                }
            }
        }
    }

    var script: String {
        """
        外部ディスプレイの実装方法を説明します。
        まず、外部ディスプレイのための設定をInfo.plistに追加します。
        が、面白い話ではないので、省略します。
        次にSceneDelegateで外部ディスプレイのための設定が必要です。
        みなさんのアプリでもしているようにSceneDelegateのwillConnectToの中でwindwoの設定をします。
        通常はsession roleの確認なんてあまりしませんが、今回はアプリのためのSceneなのか外部ディスプレイのためのSceneなのかで分岐が必要になります。
        UIWindowの作り方自体は通常のアプリと変わりません。
        """
    }
}


extension SupportExternalDisplay {
    var code: String {
"""
func scene(/* ... */) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    if session.role == .windowExternalDisplayNonInteractive {
        // 外部ディスプレイ用windowの設定
    } else {
        // iPhone用windowの設定
    }
}
"""
    }
}

struct SupportExternalDisplay_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SupportExternalDisplay()
        }
    }
}
