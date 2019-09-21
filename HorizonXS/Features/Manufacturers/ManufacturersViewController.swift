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
    func displayLoading()
    func hideLoading()
    func displayError(msg: String)
    func hideError()
}

class ManufacturersViewController: UITableViewController {
    var interactor: ManufacturersBusinessLogic?
    var router: (NSObjectProtocol & ManufacturersRoutingLogic & ManufacturersDataPassing)?
    var viewModel: Manufacturers.ViewModel?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MANUFACTURERS".localized
        doSomething()
    }

    // MARK: Routing

    // MARK: Do something
    func doSomething() {
        interactor?.getManufacturers()
    }
}

// MARK: ManufacturersDisplayLogic extension
extension ManufacturersViewController: ManufacturersDisplayLogic {
    func displaySomething(viewModel: Manufacturers.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayLoading() {

    }

    func hideLoading() {

    }

    func displayError(msg: String) {

    }

    func hideError() {

    }
}


// MARK: UITableViewDelegate extension
extension ManufacturersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.brands.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        guard let viewModel = viewModel?.brands[indexPath.row] else {
            return cell
        }
        cell.textLabel?.textColor = UIColor.appColor(viewModel.fontColor)
        cell.textLabel?.text = viewModel.name
        cell.contentView.backgroundColor = UIColor.appColor(viewModel.backgroundColor)

        return cell
    }
}
