//
//  UIView+Extension.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/22/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

// swiftlint:disable all
extension UIView {

    public func loadViewFromNib() -> UIView {
        let myType = type(of: self)
        let bundle = Bundle(for: myType)
        let nib = UINib(nibName: String(describing: myType), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView()
    }

}
