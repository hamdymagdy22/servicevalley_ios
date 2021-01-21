//
//  CLLocationValueTransformer.swift
//  Service Valley
//
//  Created by Mohammed Gamal on 1/13/21.
//  Copyright © 2021 Parth Changela. All rights reserved.
//

import Foundation
import CoreLocation
@objc(CLLocationValueTransformer)
final class CLLocationValueTransformer: NSSecureUnarchiveFromDataTransformer {
    static let name = NSValueTransformerName(rawValue: String(describing: CLLocationValueTransformer.self))
    override static var allowedTopLevelClasses: [AnyClass] {
        return [CLLocation.self]
    }
    public static func register() {
        let transformer = CLLocationValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
