//
//  Arrow.swift
//  iOSDC22
//
//  Created by Junnosuke Matsumoto on 2022/07/17.
//

import SwiftUI

struct Arrow: Shape {

    let source: Alignment
    let destination: Alignment
    let control: Alignment?
    let arrowAngle: CGFloat
    let arrowLength: CGFloat

    init(
        from source: Alignment,
        to destination: Alignment,
        control: Alignment? = nil,
        arrowAngle: CGFloat = .zero,
        arrowLength: CGFloat
    ) {
        self.source = source
        self.destination = destination
        self.control = control
        self.arrowAngle = arrowAngle
        self.arrowLength = arrowLength
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: position(for: source, in: rect))
            let destinationPosition = position(for: destination, in: rect)
            if let control = control {
                path.addQuadCurve(to: destinationPosition, control: position(for: control, in: rect))
            } else {
                path.addLine(to: destinationPosition)
            }
            path.move(to: destinationPosition)

            path.addLine(to: CGPoint(
                x: destinationPosition.x + arrowLength * cos((arrowAngle + 30) * Double.pi / 180),
                y: destinationPosition.y - arrowLength * sin((arrowAngle + 30) * Double.pi / 180)
            ))
            path.move(to: destinationPosition)
            path.addLine(to: CGPoint(
                x: destinationPosition.x + arrowLength * cos((arrowAngle - 30) * Double.pi / 180),
                y: destinationPosition.y - arrowLength * sin((arrowAngle - 30) * Double.pi / 180)
            ))
        }
    }

    private func position(for alignment: Alignment, in rect: CGRect) -> CGPoint {
        switch alignment {
        case .topLeading:     return CGPoint(x: rect.minX, y: rect.minY)
        case .top:            return CGPoint(x: rect.midX, y: rect.minY)
        case .topTrailing:    return CGPoint(x: rect.maxX, y: rect.minY)

        case .leading:        return CGPoint(x: rect.minX, y: rect.midY)
        case .center:         return CGPoint(x: rect.midX, y: rect.midY)
        case .trailing:       return CGPoint(x: rect.maxX, y: rect.midY)

        case .bottomLeading:  return CGPoint(x: rect.minX, y: rect.maxY)
        case .bottom:         return CGPoint(x: rect.midX, y: rect.maxY)
        case .bottomTrailing: return CGPoint(x: rect.maxX, y: rect.maxY)
        default: return .zero
        }
    }

    private func controlPosition(in rect: CGRect) -> CGPoint? {
        let sourcePosition = position(for: source, in: rect)
        let destinationPosition = position(for: destination, in: rect)
        if sourcePosition.x == destinationPosition.x
            || sourcePosition.y == destinationPosition.y {
            return nil
        }
        return CGPoint(
            x: (3 * sourcePosition.x + destinationPosition.x) / 4,
            y: destinationPosition.y
        )
    }
}
