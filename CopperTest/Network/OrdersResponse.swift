//
//  OrdersResponse.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import Foundation

struct OrdersResponse: Decodable {
    let orders: [Order]
}
