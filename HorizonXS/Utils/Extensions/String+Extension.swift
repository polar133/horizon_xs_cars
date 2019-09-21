//
//  String+Extension.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

extension String {

    public var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: "")
    }

}
