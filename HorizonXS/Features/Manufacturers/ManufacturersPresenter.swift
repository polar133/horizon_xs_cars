//
//  ManufacturersPresenter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ManufacturersPresentationLogic {
    func presentLoading()
    func hideLoading()
    func presentError(msg: String)
    func hideError()
    func presentManufacturers(response: Manufacturers.Response)
    func presentModel()
}

class ManufacturersPresenter: ManufacturersPresentationLogic {
    weak var viewController: ManufacturersDisplayLogic?
    var isLoading = false
    var hasError = false

    // MARK: Present Manufacturers

    func presentManufacturers(response: Manufacturers.Response) {
        let brands: [BrandViewModel] = response.brands.reduce(into: [], { brands, object in
            let odd = brands.count % 2 != 0
            brands.append(BrandViewModel(id: object.id,
                                         name: object.name,
                                         fontColor: odd ? .background : .primary,
                                         backgroundColor: odd ? .primary : .background,
                                         borderColor: .primary))
        })
        hideError()
        let viewModel = Manufacturers.ViewModel(hasMoreElements: response.hasMoreElements, brands: brands)
        viewController?.displayManufacturers(viewModel: viewModel)
        hideLoading()
    }

    func presentModel() {
        self.viewController?.goToModels()
    }

    func presentLoading() {
        isLoading = true
        self.viewController?.displayLoading()
    }

    func hideLoading() {
        if isLoading {
            self.viewController?.hideLoading()
            isLoading = false
        }
    }

    func presentError(msg: String) {
        hasError = true
        self.hideLoading()
        self.viewController?.displayError(msg: msg)
    }

    func hideError() {
        if hasError {
            self.viewController?.hideError()
            hasError = false
        }
    }
}
