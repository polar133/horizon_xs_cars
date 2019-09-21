//
//  ModelsPresenter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ModelsPresentationLogic {
    func presentSomething(response: Models.Response)
}

class ModelsPresenter: ModelsPresentationLogic {
    weak var viewController: ModelsDisplayLogic?

    // MARK: Do something

    func presentSomething(response: Models.Response) {
        let viewModel = Models.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
