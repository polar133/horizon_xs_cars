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
    func goToModels()
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

    // MARK: Load Manufacturers
    func loadManufacturers() {
        interactor?.getManufacturers()
    }

    func configTableView() {
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: ManufacturerCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: ManufacturerCell.reuseIdentifier)
        tableView.separatorStyle = .none
    }
}

// MARK: ManufacturersDisplayLogic extension
extension ManufacturersViewController: ManufacturersDisplayLogic {
    func displayManufacturers(viewModel: Manufacturers.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: Routing
    func goToModels() {
        router?.routeToModels()
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

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
        guard !isLoadingCell(for: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: ManufacturerCell.reuseIdentifier, for: indexPath) as? ManufacturerCell,
            let viewModel = viewModel?.brands[indexPath.row] else {
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
                cell.tag = indexPath.row
                cell.textLabel?.text = "Loading"
                return cell
        }
        cell.configCell(viewModel: viewModel)
        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isLoadingCell(for: indexPath.row), let viewModel = viewModel?.brands[indexPath.row] else {
            return
        }
        let request = Manufacturers.Request(id: viewModel.id, name: viewModel.name)
        self.interactor?.manufacturerSelected(request: request)
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
