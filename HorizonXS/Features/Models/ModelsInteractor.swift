//
//  ModelsInteractor.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ModelsBusinessLogic {
    func getModels()
    func modelSelected(request: Models.Request)
}

protocol ModelsDataStore {
    var manufacturerId: String { get set }
    var manufacturerName: String { get set }
    var modelName: String { get set }
}

class ModelsInteractor: ModelsBusinessLogic, ModelsDataStore {
    var presenter: ModelsPresentationLogic?
    lazy var worker = ModelsWorker()

    // MARK: DataStore variables
    var manufacturerId: String = ""
    var manufacturerName: String = ""
    var modelName: String = ""

    // MARK: Properties
    var currentPage = 0
    var totalElements: Int?
    var models: [CarModel] = []
    var isLoading: Bool = false

    // MARK: Get Model

    func getModels() {
        guard !self.manufacturerId.isEmpty, !isLoading else {
            return
        }

        guard currentPage < totalElements ?? 1 else {
            self.presenter?.hideLoading()
            return
        }

        isLoading = true
        presenter?.presentLoading()
        worker.fetchModels(manufacturer: self.manufacturerId, page: 0, callback: { [weak self] response in
            switch response {
            case .success(let entity):
                self?.currentPage += 1
                var models = self?.models ?? []
                entity.models.forEach { if !models.contains($0) { models.append($0) } }
                if self?.models != models {
                    self?.models = models
                    self?.totalElements = entity.totalPageCount
                    let response = Models.Response(hasMoreElements: (self?.currentPage ?? 1) < (entity.totalPageCount ?? 1), models: models)
                    self?.presenter?.presentModels(response: response)
                } else {
                    self?.presenter?.hideLoading()
                }
            case .failure(let error):
                self?.presenter?.presentError(msg: error.localizedDescription)
            }
            self?.isLoading = false
        })
    }

    func modelSelected(request: Models.Request) {
        self.modelName = request.name
        self.presenter?.presentModel()
    }
}
