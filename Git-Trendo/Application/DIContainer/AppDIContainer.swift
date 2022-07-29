//
//  AppDIContainer.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!, queryParameters: ["q": "language=+sort:stars"])

        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    // MARK: - DIContainers of scenes

    func makeTrendingRepoListDIContainer() -> TrendingReposSceneDIContainer {
        let dependencies = TrendingReposSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return TrendingReposSceneDIContainer(dependencies: dependencies)
    }
}
