//
//  UINavigation+Extension.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

extension UINavigationController {

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.barTintColor = UIColor.appColor(.background)
        self.navigationBar.tintColor = UIColor.appColor(.font)
        self.navigationBar.shadowImage = UIImage()
    }

}
