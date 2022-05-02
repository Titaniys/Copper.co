//
//  OrderCellViewModel.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit

final class OrderCellViewModel {

    private typealias OrderType = Order.OrderType
    
    let currency: String?
    let date: String?
    let amount: String?
    let status: String
    
    init(order: Order) {
        self.currency = order.orderType.currency(order.currency)
        self.date = order.createdAt
        self.amount = order.orderType.amount(order.amount.roundedAmount,
                                             order.currency)
        self.status = order.orderStatus.rawValue
    }
    
}

private extension String {
    var roundedAmount: String {
        let amount = Double(self) ?? 0
        return String(format: "%.4f", amount)
    }
}

private extension Order.OrderType {
    func currency(_ base: String) -> String {
        switch self {
        case .sell, .buy:
            return base // TODO: Really don't know how to configure data for those cases
        case .deposit:
            return "In \(base)"
        case .withdraw:
            return "Out \(base)"
        }
    }
    
    func amount(_ amount: String,
                _ currency: String) -> String {
        switch self {
        case .deposit, .buy:
            return "+\(amount) \(currency)"
        case .sell, .withdraw:
            return "-\(amount) \(currency)"
        }
    }
}
