//
//  SharedObjectSlide2.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/10.
//

import SlideKit
import SwiftUI

struct SharedObjectSlide2: Slide {
    var body: some View {
        HeaderSlide("解決策") {
            Text("独自のpropertyWrapperを作って、Viewをまたいで裏で状態を同期する")
            Code(code, fontSize: .code)
        }
    }

    var script: String {
        """
        そしてこんな感じで使います。
        まず上のSampleStatusのようにObservableObjectに準拠したクラスを作り、それをSampleSlideの中で宣言するだけです。
        これで複数のViewにまたがって状態を共有することができました。
        """
    }
}

private let code = """
class SampleStatus: ObservableObject {
    @Published var isHoge = false
}

struct SampleSlide: Slide {
    @SharedObject var status = SampleStatus()

    var body: some View {
        if status.isHoge {
            Text("Hoge")
        } else {
            Text("Fuga")
        }
    }
}
"""

struct SharedObjectSlide2_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SharedObjectSlide2()
        }
    }
}
