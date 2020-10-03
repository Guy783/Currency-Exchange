//
//  CurrencyPairsListDataProvider.swift
//  ExchangeRate
//
//  Created by Takomborerwa Mazarura on 14/03/2020.
//

import UIKit

final class CurrencyPairsListDataProvider: TableViewDataProvider {
    func updateViewModel(with updatedViewModel: ViewModelable) {
        // If first CurrencyPair in new view model is different to the current view model, perform an insertion of one item
        let firstIndexPath = IndexPath(item: 1, section: 0)
        if
            let newViewModelfirstItem = updatedViewModel.item(for: firstIndexPath) as? CurrencyPairFieldViewModel,
            let firstItem = self.viewModel.item(for: firstIndexPath) as? CurrencyPairFieldViewModel,
            newViewModelfirstItem.id != firstItem.id {
            viewModel = updatedViewModel
            insertNewRows(at: [firstIndexPath], with: .automatic)
        } else {
           update(with: updatedViewModel)
        }
    }
}

// MARK: - Override UITableViewDataSource
extension CurrencyPairsListDataProvider {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let field = viewModel.item(for: indexPath) as? Field, let fieldCell = dequeCell(with: field, for: tableView) else {
            return UITableViewCell()
        }
        fieldCell.update(with: field)
        return fieldCell
    }
    
    func dequeCell(with field: Field, for tableView: UITableView) -> FieldCell? {
        if field is AddItemFieldViewModel {
            return tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.className) as? AddItemTableViewCell
        } else if field is CurrencyPairFieldViewModel {
            return tableView.dequeueReusableCell(withIdentifier: CurrencyPairsTableViewCell.className) as? CurrencyPairsTableViewCell
        }
        return nil
    }
}

// MARK: - Override UITableViewDelegate
extension CurrencyPairsListDataProvider {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let field = viewModel.item(for: indexPath) as? Field {
            delegate?.didSelect(field)
        }
    }
}
