//
//  SharedObjectSlide.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/10.
//

import SlideKit
import SwiftUI

struct SharedObjectSlide1: Slide {

    enum SlidePhasedState: Int, PhasedState {
        case initial, dynamicProperty, environment, factory
    }

    @Environment(\.slideScale)
    var slideScale

    @Phase var phasedStateStore: PhasedStateStore<SlidePhasedState>

    var codes: [String] {
        code.split(separator: "\n").map { String($0) }
    }

    var body: some View {
        HeaderSlide("解決策") {
            Text("独自のpropertyWrapperを作って、Viewをまたいで裏で状態を同期する")
            Code(code, fontSize: .code)
                .overlay {
                    if phasedStateStore.when(.dynamicProperty) {
                        OverlaySheet(topHeight: 38, height: 42)
                        CodeCaption(text: "DynamicPropertyに準拠するとpropertyWrapperの内部で\n@Environmentや@ObservableObjectが使える")
                            .slideOffset(y: -100)
                    }
                }
                .overlay {
                    if phasedStateStore.when(.environment) {
                        OverlaySheet(topHeight: 80, height: 88)
                        CodeCaption(text: "ObservableObjectが保管される場所をEnvironment経由で共有する")
                            .slideOffset(x: -290, y: -40)
                    }
                }
                .overlay {
                    if phasedStateStore.when(.factory) {
                        OverlaySheet(topHeight: 300, height: 120)
                        CodeCaption(text: "observableObjectContainerから対象のObservableObjectを取り出す\nもし、なかったら作る")
                            .slideOffset(x: -270, y: 250)
                    }
                }
        }
    }

    var script: String {
        switch phasedStateStore.current {
        case .initial:
            return """
                さて、解決策です。
                今回はSharedObjectというCustom PropertyWrapperを用意しました。
                """
        case .dynamicProperty:
            return """
                このpropertyWrapperはDynamicPropertyに準拠しているので、内部で@EnvironmentやObservedObjectといったpropertyWrapperが使えます。
                """
        case .environment:
            return """
                そして今回独自に定義したobservableObjectContainerというenvironmentの値を取得します。
                observableObjectContainerは、その名の通り、observableObjectをストックするcontainerです。
                """
        case .factory:
            return """
                そしてinitでこのobservableObjectContainerからobservableObjectを取り出します。
                もしcontainerになかった場合は、factoryクロージャーを使って生成し、observableObjectContainerに保存されます。
                """
        }
    }
}

private let code = """
@propertyWrapper
public struct SharedObject<Object: ObservableObject>: DynamicProperty {
  @Environment(\\.observableObjectContainer)
  private var observableObjectContainer

  @ObservedObject
  private var internalObservableObject = InternalObservableObject<Object>()

  public init(wrappedValue factory: @autoclosure @escaping () -> Object) {
    internalObservableObject.observedObject = observableObjectContainer.resolve(factory)
  }
  // 省略
}
"""

struct SharedObjectSlide_Previews: PreviewProvider {
    static var previews: some View {
        SlidePreview {
            SharedObjectSlide1()
        }
    }
}
