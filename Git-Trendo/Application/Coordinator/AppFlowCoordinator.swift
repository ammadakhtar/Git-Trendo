//
//  AppFlowCoordinator.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import UIKit

final class AppFlowCoordinator: Coordinator {

    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    // Starts the flow of the application
    func start() {
        let trendingReposDIContainer = appDIContainer.makeTrendingRepoListDIContainer()
        let trendingReposVIewController = trendingReposDIContainer.makeTrendingRepoListViewController()
        navigationController.pushViewController(trendingReposVIewController, animated: true)
    }

    // pops ViewController
    // we don't need this in the task but is written from a scaleable solution's point of view
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
