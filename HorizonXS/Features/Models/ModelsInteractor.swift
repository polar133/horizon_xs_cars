//
//  ModelsInteractor.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ModelsBusinessLogic {
    func doSomething(request: Models.Request)
}

protocol ModelsDataStore {
    var id: String { get set }
    var name: String { get set }
}

class ModelsInteractor: ModelsBusinessLogic, ModelsDataStore {
    var presenter: ModelsPresentationLogic?
    var worker: ModelsWorker?
    var id: String = ""
    var name: String = ""

    // MARK: Do something

    func doSomething(request: Models.Request) {
        worker = ModelsWorker()
        worker?.fetchModels(manufacturer: "120", page: 0, callback: { [weak self] response in

        })

        let response = Models.Response()
        presenter?.presentSomething(response: response)
    }
}
