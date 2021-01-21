//
//  Extensions.swift
//  khomasy
//
//  Created by Mohammed Gamal on 3/31/18.
//  Copyright © 2018 Khomasy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(cornerRadius: CGFloat? = nil,
                   shadowRadius: CGFloat = 1,
                   shadowColor: UIColor = UIColor.black,
                   opacity: Float = 0.4,
                   offset: CGSize = CGSize(width: 0.0, height: 0.5))
    {
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = bounds.size.height / 2
        }
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
}

extension UITextField {
    func addMarginViewWidth(_ width: CGFloat) {
        let leftMarginView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                  size: CGSize(width: width,
                                                               height: bounds.size.height)))
        leftView = leftMarginView
        let rightMarginView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                   size: CGSize(width: width,
                                                                height: bounds.size.height)))
        rightView = rightMarginView
        leftViewMode = .always
        rightViewMode = .always
    }
}

//class TriangleView : UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func draw(_ rect: CGRect) {
//
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        context.beginPath()
//        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
//        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
//        context.closePath()
//
//        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
//        context.fillPath()
//    }
//}
