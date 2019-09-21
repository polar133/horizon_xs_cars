//
//  ManufacturersViewController.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import UIKit

protocol ManufacturersDisplayLogic: class {
    func displayManufacturers(viewModel: Manufacturers.ViewModel)
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
        configTableView()
        loadManufacturers()
    }

    // MARK: Routing

    // MARK: Load Manufacturers
    func loadManufacturers() {
        interactor?.getManufacturers()
    }

    func configTableView() {
        tableView.prefetchDataSource = self
    }
}

// MARK: ManufacturersDisplayLogic extension
extension ManufacturersViewController: ManufacturersDisplayLogic {
    func displayManufacturers(viewModel: Manufacturers.ViewModel) {
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
extension ManufacturersViewController: UITableViewDataSourcePrefetching {

    func isLoadingCell(for tag: Int) -> Bool {
      return tag + 1 >= viewModel?.brands.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.hasMoreElements ? viewModel.brands.count : viewModel.brands.count - 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.tag = indexPath.row
        if isLoadingCell(for: indexPath.row) {
            cell.textLabel?.text = "Loading"
        } else {
            guard let viewModel = viewModel?.brands[indexPath.row] else {
                return cell
            }
            cell.textLabel?.textColor = UIColor.appColor(viewModel.fontColor)
            cell.textLabel?.text = viewModel.name
            cell.contentView.backgroundColor = UIColor.appColor(viewModel.backgroundColor)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let tag = tableView.visibleCells.last?.tag else {
            return
        }
        if isLoadingCell(for: tag) {
          loadManufacturers()
        }
    }
}
