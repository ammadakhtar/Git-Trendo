//
//  NetworkSessionManagerMock.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 30/07/2022.
//

import Foundation

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?

    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
