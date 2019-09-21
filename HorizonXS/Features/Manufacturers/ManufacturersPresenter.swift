//
//  ManufacturersPresenter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

protocol ManufacturersPresentationLogic {
    func presentSomething(response: Manufacturers.Response)
}

class ManufacturersPresenter: ManufacturersPresentationLogic {
    weak var viewController: ManufacturersDisplayLogic?

    // MARK: Do something

    func presentSomething(response: Manufacturers.Response) {
        let viewModel = Manufacturers.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
