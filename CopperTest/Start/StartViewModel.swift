//
//  StartViewModel.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit

final class StartViewModel {
    
    private var router: Router?
    
    init(router: Router) {
        self.router = router
    }
    
    func routeToOrders() {
        router?.routeToOrders()
    }

}
