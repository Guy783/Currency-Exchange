//
//  BaseTableViewable.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import UIKit

protocol BaseTableViewable {
    var tableView: UITableView! { get }
    var dataProvider: TableDataProviderable! { get set }

    func refresh()
    func setupTableView(with dataSource: UITableViewDataSource, delegate: UITableViewDelegate)
}

extension BaseTableViewable {
    func setupTableView(with dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
}
