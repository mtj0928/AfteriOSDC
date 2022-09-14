//
//  CodeCaption.swift
//  AfteriOSDC
//
//  Created by Junnosuke Matsumoto on 2022/09/11.
//

import SwiftUI

struct CodeCaption: View {

    @Environment(\.slideScale)
    var slideScale

    let text: String

    var body: some View {
        Text(text)
            .slideFontSize(.callout)
            .slidePadding()
            .background(.white)
            .slideCornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: slideScale * 10)
                    .stroke(style: .init(lineWidth: slideScale * 2))
            }
    }
}

struct CodeCaption_Previews: PreviewProvider {
    static var previews: some View {
        CodeCaption(text: "Hoge")
    }
}
