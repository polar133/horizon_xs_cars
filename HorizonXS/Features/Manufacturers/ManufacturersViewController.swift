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
    private var loadingView: LoadingView?
    private var errorView: ErrorView?

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
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.reuseIdentifier)
        tableView.separatorStyle = .none
    }

    func showEmptyState() {
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        noDataLabel.text = "NO_MANUFACTURERS".localized
        noDataLabel.textColor = UIColor.appColor(.primary)
        noDataLabel.textAlignment = NSTextAlignment.center
        self.tableView.backgroundView = noDataLabel
        self.tableView.isScrollEnabled = false
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
        self.loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        DispatchQueue.main.async { [weak self] in
            self?.tableView.addSubview(self?.loadingView ?? UIView())
            self?.loadingView?.startLoading()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView?.endLoading()
            self?.loadingView?.removeFromSuperview()
            self?.loadingView = nil
        }
    }

    func displayError(msg: String) {
        guard viewModel == nil else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: self?.tableView.bounds.size.width ?? 0, height: self?.tableView.bounds.size.height ?? 0))
            self?.errorView?.delegate = self
            self?.errorView?.setError(msg)
            self?.errorView?.setErrorTextColor(UIColor.appColor(.primary) ?? .black)
            self?.tableView.backgroundView = self?.errorView
            self?.tableView.isScrollEnabled = false
        }
    }

    func hideError() {
        DispatchQueue.main.async { [weak self] in
            self?.errorView = nil
            self?.tableView.backgroundView = nil
            self?.tableView.isScrollEnabled = true
        }
    }
}

extension ManufacturersViewController: ErroViewDelegate {
    func didTapTryAgain(in errorView: ErrorView) {
        self.loadManufacturers()
    }
}

// MARK: UITableViewDelegate extension
extension ManufacturersViewController: UITableViewDataSourcePrefetching {

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        guard !viewModel.brands.isEmpty else {
            self.showEmptyState()
            return 0
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.hasMoreElements ? viewModel.brands.count + 1 : viewModel.brands.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !isLoadingCell(for: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: ManufacturerCell.reuseIdentifier, for: indexPath) as? ManufacturerCell,
            let viewModel = viewModel?.brands[indexPath.row] else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier, for: indexPath) as? LoadingCell {
                    cell.loadingActivity.startAnimating()
                    cell.tag = indexPath.row
                    return cell
                } else {
                    return UITableViewCell()
                }
        }
        cell.configCell(viewModel: viewModel)
        cell.tag = indexPath.row
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

    func isLoadingCell(for tag: Int) -> Bool {
      return tag + 1 > viewModel?.brands.count ?? 0
    }
}
