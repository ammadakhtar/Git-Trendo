//
//  NetworkConfigurableMock.swift
//  Git-TrendoTests
//
//  Created by Ammad Akhtar on 30/07/2022.
//

import Foundation

final class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
