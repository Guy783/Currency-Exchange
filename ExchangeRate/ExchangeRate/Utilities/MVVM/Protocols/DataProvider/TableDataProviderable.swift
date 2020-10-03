//
//  TableViewDataProvider.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//
//  TableDataProviderable: - A protocol for all TableDataProvider to implement
//  Each TableDataProvider must also implement UITableViewDelegate & UITableViewDataSource

import UIKit

protocol TableDataProviderable: DataProvidable, UITableViewDataSource & UITableViewDelegate {
    var tableView: UITableView { get set }
    var delegate: DataProviderDelegate? { get set }
    
    init(with tableView: UITableView, viewModel: ViewModelable, delegate: DataProviderDelegate?)
    
    func update(with viewModel: ViewModelable)

    func reloadData()
    func reloadTableView()
    func updateRefreshControl(withIsLoadingStatus isLoading: Bool)
    func insertNewRows(at indexes: [IndexPath], with: UITableView.RowAnimation)
}

extension TableDataProviderable where Self: UITableViewDataSource & UITableViewDelegate {
    func update(with viewModel: ViewModelable) {
        self.viewModel = viewModel
        reloadTableView()
    }
    
    func reloadData() {
        delegate?.reloadData()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateRefreshControl(withIsLoadingStatus: false)
        }
    }
    
    func updateRefreshControl(withIsLoadingStatus isLoading: Bool) {
        if isLoading {
            tableView.refreshControl?.beginRefreshing()
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }
}
