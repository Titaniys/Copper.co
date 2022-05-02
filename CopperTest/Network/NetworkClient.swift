//
//  NetworkClient.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import Foundation
import UIKit

enum Error: Swift.Error {
    case general
    case invalid(response: URLResponse?)
    case network(error: Swift.Error, response: URLResponse?)
    case parsing(error: Swift.Error)
}

final class NetworkClient {

    private let responseHandler: ResponseHandler
    private let urlSession = URLSession.shared
    private let baseURL = "https://assessments.stage.copper.co"
    private let endpoint = "ios/orders"

    init() {
        self.responseHandler = ResponseHandler()
    }
     
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            completion(.failure(.general))
            return
        }
        urlSession.dataTask(with: url) { (jsonData, response, error) in
            let result: Result<OrdersResponse, Error> = self.responseHandler.handle(data: jsonData,
                                                                                    error: error,
                                                                                    response: response)
            completion(result.map { $0.orders })
        }.resume()
    }
}
