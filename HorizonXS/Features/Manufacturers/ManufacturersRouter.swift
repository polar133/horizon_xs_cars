//
//  ManufacturersRouter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ManufacturersRoutingLogic {
    func routeToModels()
}

protocol ManufacturersDataPassing {
    var dataStore: ManufacturersDataStore? { get }
}

class ManufacturersRouter: NSObject, ManufacturersRoutingLogic, ManufacturersDataPassing {
    weak var viewController: ManufacturersViewController?
    var dataStore: ManufacturersDataStore?

    // MARK: Routing
    func routeToModels() {
        let destinationVC = ModelsBuilder.build()
        guard let dataStore = dataStore, var destinationDS = destinationVC.router?.dataStore else {
            return
        }
        passDataToModels(source: dataStore, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }

    // MARK: Passing data

    func passDataToModels(source: ManufacturersDataStore, destination: inout ModelsDataStore) {
        destination.name = source.name
        destination.id = source.id
    }
}
