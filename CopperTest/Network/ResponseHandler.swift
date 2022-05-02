//
//  ResponseHandler.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import Foundation

final class ResponseHandler {
    func handle<Type: Decodable>(data: Data?,
                                 error: Swift.Error?,
                                 response: URLResponse?) -> Result<Type, Error> {
        if let error = error {
            return .failure(.network(error: error, response: response))
        }

        if let jsonData = data {
            do {
                return .success(try JSONDecoder().decode(Type.self, from: jsonData))
            } catch {
                print("Error info: \(error)")
                return .failure(.parsing(error: error))
            }
        } else {
            return .failure(.invalid(response: response))
        }
    }
}
