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
}

protocol ManufacturersDataStore {
}

class ManufacturersInteractor: ManufacturersBusinessLogic, ManufacturersDataStore {
    var presenter: ManufacturersPresentationLogic?
    lazy var worker = ManufacturersWorker()

    private var currentPage = 0
    private var totalElements: Int?
    private var brands: Set<Brand> = []

    // MARK: Get manufacturers from service (worker)
    func getManufacturers() {
        if brands.isEmpty {
            presenter?.presentLoading()
        }

        worker.fetchManufacturers(page: currentPage, callback: { [weak self] response in
            switch response {
            case .success(let entity):
                var brands = self?.brands ?? []
                entity.brands.forEach { brands.insert($0) }
                self?.brands = entity.brands
                self?.totalElements = entity.totalPageCount
                let response = Manufacturers.Response(brands: brands)
                self?.presenter?.presentManufacturers(response: response)
            case .failure(let error):
                self?.presenter?.presentError(msg: error.localizedDescription)
            }
        })
    }

}
