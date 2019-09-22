//
//  ManufacturersInteractor.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ManufacturersBusinessLogic {
    func getManufacturers()
    func manufacturerSelected(request: Manufacturers.Request)
}

protocol ManufacturersDataStore {
    var id: String { get set }
    var name: String { get set }
}

class ManufacturersInteractor: ManufacturersBusinessLogic, ManufacturersDataStore {
    var presenter: ManufacturersPresentationLogic?
    lazy var worker = ManufacturersWorker()

    var currentPage = 0
    var totalElements: Int?
    var brands: [Brand] = []
    var isLoading: Bool = false
    var id: String = ""
    var name: String = ""

    // MARK: Get manufacturers from service (worker)
    func getManufacturers() {
        guard !isLoading else {
            return
        }
        guard currentPage < totalElements ?? 1 else {
            self.presenter?.hideLoading()
            return
        }

        isLoading = true
        presenter?.presentLoading()
        worker.fetchManufacturers(page: currentPage, callback: { [weak self] response in
            switch response {
            case .success(let entity):
                self?.currentPage += 1
                var brands = self?.brands ?? []
                entity.brands.forEach { if !brands.contains($0) { brands.append($0) } }
                self?.brands = brands
                self?.totalElements = entity.totalPageCount
                let response = Manufacturers.Response(hasMoreElements: (self?.currentPage ?? 1) < (entity.totalPageCount ?? 1), brands: brands)
                self?.presenter?.presentManufacturers(response: response)
            case .failure(let error):
                self?.presenter?.presentError(msg: error.localizedDescription)
            }
            self?.isLoading = false
        })
    }

    func manufacturerSelected(request: Manufacturers.Request) {
        self.id = request.id
        self.name = request.name
        self.presenter?.presentModel()
    }

}
