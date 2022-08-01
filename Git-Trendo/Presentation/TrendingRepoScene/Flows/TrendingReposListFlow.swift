//
//  TrendingReposListFlow.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import UIKit

protocol TrendingReposListFlowCoordinatorDependencies: AnyObject  {
    func makeTrendingReposListViewController() -> TrendingRepoListViewController
}

final class TrendingReposListFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: TrendingReposListFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: TrendingReposListFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = dependencies.makeTrendingReposListViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}
