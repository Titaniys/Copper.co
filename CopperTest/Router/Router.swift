//
//  Router.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit
import CoreData

final class Router {
    
    private enum Const {
        static let modelName = "OrderDB"
    }
    
    private weak var root: UIViewController?
    
    func run() -> UIViewController {
        let storeClient = StoreClient(modelName: Const.modelName)
        
        var isEmptyStorage: Bool {
            do {
                let request = NSFetchRequest<OrderDB>(entityName: Const.modelName)
                let count  = try storeClient.viewContext.count(for: request)
                return count == 0
            } catch {
                return true
            }
        }
        
        if isEmptyStorage {
            let viewModel = StartViewModel(router: self)
            let startVC = StartViewController(viewModel: viewModel)
            self.root = startVC
            return startVC
        } else {
            let ordersVC = assemblyOrdersVC(isFirstLaunch: false)
            return ordersVC
        }
        
    }
    
    func routeToOrders() {
        let vc = assemblyOrdersVC(isFirstLaunch: true)
        root?.present(vc, animated: true)
    }
    
    private func assemblyOrdersVC(isFirstLaunch: Bool) -> UIViewController {
        let networkClient = NetworkClient()
        let storeClient = StoreClient(modelName: Const.modelName)
        
        let viewModel = OrdersViewModel(networkClient: networkClient,
                                        storeClient: storeClient,
                                        isFirstLaunch: isFirstLaunch)
        let viewController = OrdersViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
    
}
