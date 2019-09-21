//
//  ManufacturersViewController.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import UIKit

protocol ManufacturersDisplayLogic: class {
    func displaySomething(viewModel: Manufacturers.ViewModel)
}

class ManufacturersViewController: UITableViewController, ManufacturersDisplayLogic {
    var interactor: ManufacturersBusinessLogic?
    var router: (NSObjectProtocol & ManufacturersRoutingLogic & ManufacturersDataPassing)?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Routing

    
    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = Manufacturers.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: Manufacturers.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

// UITableViewDelegate extension
extension ManufacturersViewController {

}
