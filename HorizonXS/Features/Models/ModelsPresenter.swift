//
//  ModelsPresenter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ModelsPresentationLogic {
    func presentLoading()
    func hideLoading()
    func presentError(msg: String)
    func hideError()
    func presentModels(response: Models.Response)
    func presentModel()
}

class ModelsPresenter: ModelsPresentationLogic {
    weak var viewController: ModelsDisplayLogic?

    // MARK: Properties
    var isLoading = false
    var hasError = false

    // MARK: Do something
    func presentModels(response: Models.Response) {
        let models: [ModelViewModel] = response.models.reduce(into: [], { models, object in
            let odd = models.count % 2 != 0
            models.append(ModelViewModel(name: object.name.capitalized,
                                fontColor: odd ? .background : .secondary,
                                backgroundColor: odd ? .secondary : .background,
                                borderColor: .secondary ))
        })
        hideError()
        let viewModel = Models.ViewModel(hasMoreElements: response.hasMoreElements, models: models)
        viewController?.displayModels(viewModel: viewModel)
        hideLoading()
    }

    func presentModel() {
        self.viewController?.showModel()
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
        self.viewController?.displayError(msg: msg)
    }

    func hideError() {
        if hasError {
            self.viewController?.hideError()
            hasError = false
        }
    }
}
