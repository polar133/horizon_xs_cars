//
//  ModelsBuilder.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

enum ModelsBuilder {
    static func build() -> ModelsViewController {

        let viewController = ModelsViewController()
        // connecting all components together
        let interactor = ModelsInteractor()
        let presenter = ModelsPresenter()
        let router = ModelsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        return viewController
    }
}
