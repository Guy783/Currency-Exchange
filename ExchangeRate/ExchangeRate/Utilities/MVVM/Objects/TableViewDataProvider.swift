//
//  TableViewDataProvider.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 12/03/2020.
//
//  Provides data to the table view using the view model
//  Provides data to the view model from actions taken on the table view

import UIKit

class TableViewDataProvider: NSObject, TableDataProviderable {
    var tableView: UITableView
    var viewModel: ViewModelable
    weak var delegate: DataProviderDelegate?
    
    required init(with tableView: UITableView, viewModel: ViewModelable, delegate: DataProviderDelegate?) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    func insertNewRows(at indexes: [IndexPath], with animation: UITableView.RowAnimation) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexes, with: animation)
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension TableViewDataProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let field = viewModel.item(for: indexPath) as? Field {
            cell.textLabel?.text = field.title
            cell.detailTextLabel?.text = field.detail
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewDataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let field = viewModel.item(for: indexPath) as? Field {
            delegate?.didSelect(field)
        }
    }
}
