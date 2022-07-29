//
//  SceneDelegate.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDIContainer = AppDIContainer()
    var appFlowCoodinator: AppFlowCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)

        let navigationController = UINavigationController()
        window.rootViewController = navigationController

        appFlowCoodinator = AppFlowCoordinator(navigationController: navigationController,
                                               appDIContainer: appDIContainer)
        appFlowCoodinator?.start()
        self.window = window
        window.makeKeyAndVisible()
    }
}

