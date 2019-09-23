//
//  ModelsRouter.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import UIKit

@objc protocol ModelsRoutingLogic {
    func showAlert()
}

protocol ModelsDataPassing {
    var dataStore: ModelsDataStore? { get }
}

class ModelsRouter: NSObject, ModelsRoutingLogic, ModelsDataPassing {
    weak var viewController: ModelsViewController?
    var dataStore: ModelsDataStore?

    // MARK: Routing
    func showAlert() {
        guard let dataStore = self.dataStore else {
            return
        }
        let alert = UIAlertController(title: "SELECTION".localized, message: "\(dataStore.manufacturerName) - \(dataStore.modelName)", preferredStyle: .alert)
        viewController?.modalPresentationStyle = .overCurrentContext
        let cancelAction = UIAlertAction.init(title: "OK".localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        viewController?.present(alert, animated: true, completion: nil)
    }

}
