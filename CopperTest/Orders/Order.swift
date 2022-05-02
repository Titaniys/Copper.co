//
//  Order.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import Foundation

struct Order: Decodable {
    
    enum OrderType: String, Decodable {
        case deposit
        case withdraw
        case buy
        case sell
    }
    
    enum OrderStatus: String, Decodable {
        case executed
        case canceled
        case approved
        case processing
    }
    
    let orderId: String
    let currency: String
    let amount: String
    let orderType: OrderType
    let orderStatus: OrderStatus
    let createdAt: String
        
    static private let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        return dateFormatter
    }()
    
    init(orderDB: OrderDB) {
        self.orderId = orderDB.orderId ?? ""
        self.currency = orderDB.currency ?? ""
        self.amount = String(orderDB.amount)
        self.orderType = OrderType(rawValue: orderDB.orderTypeRaw ?? "")!
        self.orderStatus = OrderStatus(rawValue: orderDB.orderStatusRaw ?? "")!
        self.createdAt = Order.formatter.string(from: orderDB.createdAt ?? Date(timeIntervalSinceNow: 0))
    }
    
}
