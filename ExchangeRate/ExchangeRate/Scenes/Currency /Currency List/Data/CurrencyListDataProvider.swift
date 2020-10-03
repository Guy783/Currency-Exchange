//
//  CurrencyListDataProvider.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 11/03/2020.
//

import UIKit
final class CurrencyListDataProvider: TableViewDataProvider {}

// MARK: - Override UITableViewDataSource
extension CurrencyListDataProvider {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.className) as? CurrencyTableViewCell else {
            return UITableViewCell()
        }
        if let field = viewModel.item(for: indexPath) as? Field {
            cell.update(with: field)
        }
        return cell
    }
}

// MARK: - Override UITableViewDelegate
extension CurrencyListDataProvider {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let field = viewModel.item(for: indexPath) as? Field {
            delegate?.didSelect(field)
        }
    }
}
