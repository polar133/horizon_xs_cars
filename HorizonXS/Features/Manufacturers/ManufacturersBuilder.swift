//
//  ManufacturersBuilder.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

enum ManufacturersBuilder {
    static func build() -> ManufacturersViewController {

        let viewController = ManufacturersViewController()
        // connecting all components together
        let interactor = ManufacturersInteractor()
        let presenter = ManufacturersPresenter()
        let router = ManufacturersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
}
