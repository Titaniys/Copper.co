//
//  OrdersViewModel.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import Foundation
import CoreData

enum LoadingStatus {
    case loading
    case loaded
    case error
}

final class OrdersViewModel {

    let isFirstLaunch: Bool

    var viewContext: NSManagedObjectContext {
        storeClient.viewContext
    }
    
    private let networkClient: NetworkClient
    private let storeClient: StoreClient
    
    init(networkClient: NetworkClient,
         storeClient: StoreClient,
         isFirstLaunch: Bool) {
        self.networkClient = networkClient
        self.storeClient = storeClient
        self.isFirstLaunch = isFirstLaunch
    }
    
    func fetchOrders(completion: @escaping (LoadingStatus) -> Void) {
        completion(.loading)
        networkClient.fetchOrders { [weak self] result in
            self?.handleData(result: result, completion: completion)
        }
    }
    
    private func handleData(result: Result<[Order], Error>,
                            completion: @escaping (LoadingStatus) -> Void) {
        switch result {
        case .success(let orders):
            DispatchQueue.main.async {
                completion(.loaded)
            }
            self.storeClient.saveOrders(orders: orders)
        case .failure:
            completion(.error)
        }
    }
}
