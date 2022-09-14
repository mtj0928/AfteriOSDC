//
//  SelfIntroductionSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/06.
//

import SwiftUI
import SlideKit

struct SelfIntroductionSlide: Slide {

    @Environment(\.slideScale)
    var scale

    var body: some View {
        HeaderSlide("自己紹介") {
            item(name: "名前", content: "まつじ")
            item(name: "担当", content: "LINE iOS")
            item(name: "iOSDCでのトーク", content: "iOS15からのCommunication NotificationとSiri")
            item(name: "趣味", content: "個人開発 / 囲碁")
            item(name: "Twitter", content: "@mtj_j")
        }
        .overlay {
            SlideHStack(alignment: .bottom) {
                Text("iOSDCの漫画に\n登場してます")
                    .slideFontSize(32)
                    .multilineTextAlignment(.trailing)
                Image("matsuji")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.init(degrees: 20))
                    .slideFrame(width: 400)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(style: .init(lineWidth: 2 * scale))
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .slidePadding(.trailing, 140)
            .slidePadding(.bottom, 40)
        }
    }

    private func item(name: String, content: String) -> some View {
        SlideHStack(spacing: 32) {
            Text(name)
                .fontWeight(.semibold)
            Capsule()
                .foregroundColor(.accentColor)
                .slideFrame(width: 8)
            Text(content)
        }
        .slideFontSize(.body)
        .fixedSize()
    }

    var script: String {
        """
        まつじと申します。コミュニケーションアプリLINE iOSの開発を担当しています。
        iOSDCではiOS15からのCommunication NotificationとSiriというタイトルで発表しました。
        趣味は囲碁なんですが、誰もやってくれる友達がいないので、もしできるよって人は声かけてください。
        twitterもしているので、もしよかったらフォローしてください。
        ちなみにiOSDCの漫画に登場しています。
        """
    }
}

struct SelfIntroductionSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SelfIntroductionSlide()
        }
    }
}
