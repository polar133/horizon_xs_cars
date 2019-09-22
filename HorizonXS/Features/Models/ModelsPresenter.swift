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

    // MARK: Do something
    func presentLoading() {

    }

    func hideLoading() {

    }

    func presentError(msg: String) {

    }

    func hideError() {

    }

    func presentModels(response: Models.Response) {

    }

    func presentModel() {

    }

}
