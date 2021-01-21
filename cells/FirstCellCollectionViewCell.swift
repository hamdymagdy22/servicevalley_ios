//
//  FirstCellCollectionViewCell.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 9/18/19.
//  Copyright © 2019 Parth Changela. All rights reserved.
//

import UIKit

class FirstCellCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var picView: UIView!
    @IBOutlet weak var imgBar: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
   
    @IBOutlet weak var diamondView: UIView!
    
    
    
}
extension UIView {
    func addDiamondMask(cornerRadius: CGFloat = 0) {
        let path = UIBezierPath()

        let points = [
            CGPoint(x: bounds.midX, y: bounds.minY),
            CGPoint(x: bounds.maxX, y: bounds.midY),
            CGPoint(x: bounds.midX, y: bounds.maxY),
            CGPoint(x: bounds.minX, y: bounds.midY)
        ]

        path.move(to: point(from: points[0], to: points[1], distance: cornerRadius, fromStart: true))
        for i in 0 ..< 4 {
            path.addLine(to: point(from: points[i], to: points[(i + 1) % 4], distance: cornerRadius, fromStart: false))
            path.addQuadCurve(to: point(from: points[(i + 1) % 4], to: points[(i + 2) % 4], distance: cornerRadius, fromStart: true), controlPoint: points[(i + 1) % 4])
        }
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor

        layer.mask = shapeLayer
    }

    private func point(from point1: CGPoint, to point2: CGPoint, distance: CGFloat, fromStart: Bool) -> CGPoint {
        let start: CGPoint
        let end: CGPoint

        if fromStart {
            start = point1
            end = point2
        } else {
            start = point2
            end = point1
        }
        let angle = atan2(end.y - start.y, end.x - start.x)
        return CGPoint(x: start.x + distance * cos(angle), y: start.y + distance * sin(angle))
    }

}
