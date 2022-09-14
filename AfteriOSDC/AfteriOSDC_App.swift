//
//  AfteriOSDC.swift
//
//  Created by Junnosuke Matsumoto on 2022/08/26.
//

import Combine
import SwiftUI
import SlideKit

@main
struct AfteriOSDC_App: App {

    private static let configuration = SlideConfiguration()

    var slideSize: CGSize { Self.configuration.size }

    @ObservedObject
    var slideIndexController: SlideIndexController

    private var cancelable: AnyCancellable?

    init() {
        self.slideIndexController = Self.configuration.slideIndexController
        if let index = UserDefaults.standard.object(forKey: "index") as? Int,
           index < slideIndexController.slides.count {
            slideIndexController.move(to: index)
        }

        cancelable = slideIndexController.$currentIndex.sink { index in
            UserDefaults.standard.set(index, forKey: "index")
        }
    }

    var body: some Scene {
        WindowGroup {
            PresentationView(slideSize: slideSize) {
                SlideRouterView(slideIndexController: slideIndexController)
                    .background {
                        if 0 < slideIndexController.currentIndex && slideIndexController.currentIndex <= 6 {
                            Text("このスライドのリポジトリ : https://github.com/mtj0928/AfteriOSDC")
                                .slideFontSize(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                                .slidePadding()
                        }
                    }
                    .background(.white)
            }
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(after: .undoRedo) {
                forwardButton(.rightArrow)
                forwardButton(.return)
                backButton(.leftArrow)
            }

            CommandGroup(after: .windowList) {
                Button("Open Presenter Window") { NSWorkspace.shared.open(URL(string: "AfteriOSDC://editor")!) }
                    .keyboardShortcut("p", modifiers: .command)
            }
        }

        WindowGroup {
            macOSPresenterView(slideSize: slideSize, slideIndexController: slideIndexController) {
                SlideRouterView(slideIndexController: slideIndexController)
                    .background(.white)
            }
            .font(.system(size: 40))
        }
        .handlesExternalEvents(matching: ["editor"])
    }
}

extension AfteriOSDC_App {

    private func forwardButton(_ key: KeyEquivalent) -> some View {
        Button("forward") { slideIndexController.forward() }
            .keyboardShortcut(key, modifiers: [])
    }

    private func backButton(_ key: KeyEquivalent) -> some View {
        Button("back") { slideIndexController.back() }
            .keyboardShortcut(key, modifiers: [])
    }
}
