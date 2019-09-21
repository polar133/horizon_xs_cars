//
//  ManufacturersInteractor.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ManufacturersBusinessLogic {
    func doSomething(request: Manufacturers.Request)
}

protocol ManufacturersDataStore {
}

class ManufacturersInteractor: ManufacturersBusinessLogic, ManufacturersDataStore {
    var presenter: ManufacturersPresentationLogic?
    var worker: ManufacturersWorker?

    // MARK: Do something

    func doSomething(request: Manufacturers.Request) {
        worker = ManufacturersWorker()
        worker?.fetchManufacturers(callback: {[weak self] response in

        })

        let response = Manufacturers.Response()
        self.presenter?.presentSomething(response: response)
    }
}
