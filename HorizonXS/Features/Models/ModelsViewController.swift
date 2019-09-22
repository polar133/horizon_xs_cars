//
//  ModelsViewController.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol ModelsDisplayLogic: class {
    func displayModels(viewModel: Models.ViewModel)
    func displayLoading()
    func hideLoading()
    func displayError(msg: String)
    func hideError()
    func showModel()
}

class ModelsViewController: UITableViewController {
    var interactor: ModelsBusinessLogic?
    var router: (NSObjectProtocol & ModelsRoutingLogic & ModelsDataPassing)?

    // MARK: Properties
    var viewModel: Models.ViewModel?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadModels()
    }

    func loadModels() {
        interactor?.getModels()
    }

    func configTableView() {
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: ModelCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: ModelCell.reuseIdentifier)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.reuseIdentifier)
        tableView.separatorStyle = .none
    }

    func showEmptyState() {
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        noDataLabel.text = "NO_MODELS".localized
        noDataLabel.textColor = UIColor.appColor(.secondary)
        noDataLabel.textAlignment = NSTextAlignment.center
        self.tableView.backgroundView = noDataLabel
        self.tableView.isScrollEnabled = false
    }
}

extension ModelsViewController: ModelsDisplayLogic {
    func displayModels(viewModel: Models.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
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

    func showModel() {
        DispatchQueue.main.async { [weak self] in
            self?.router?.showAlert()
        }
    }
}

// MARK: UITableViewDelegate extension
extension ModelsViewController: UITableViewDataSourcePrefetching {

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        guard !viewModel.models.isEmpty else {
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
        return viewModel.hasMoreElements ? viewModel.models.count + 1 : viewModel.models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !isLoadingCell(for: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: ModelCell.reuseIdentifier, for: indexPath) as? ModelCell,
            let viewModel = viewModel?.models[indexPath.row] else {
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
        guard !isLoadingCell(for: indexPath.row), let viewModel = viewModel?.models[indexPath.row] else {
            return
        }
        let request = Models.Request(name: viewModel.name)
        self.interactor?.modelSelected(request: request)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let tag = tableView.visibleCells.last?.tag else {
            return
        }
        if isLoadingCell(for: tag) {
          loadModels()
        }
    }

    func isLoadingCell(for tag: Int) -> Bool {
      return tag + 1 > viewModel?.models.count ?? 0
    }

}
