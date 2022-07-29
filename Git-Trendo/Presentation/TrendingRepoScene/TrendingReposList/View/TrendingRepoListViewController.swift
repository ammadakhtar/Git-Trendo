//
//  TrendingRepoListViewController.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import UIKit

final class TrendingRepoListViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: TrendingRepoListViewModel

    // MARK: - LifeCycle Methods

    init(viewModel: TrendingRepoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Private Methods

    private func bind(to viewModel: TrendingRepoListViewModel) {
        viewModel.repos.observe(on: self) { [weak self] repos in
            self?.updateItems()
        }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }

    private func updateItems() {
    }

    private func updateLoading(_ loading: TrendingRepositoriesListViewModelLoading?) {
        switch loading {
        case .firstPage:
            break
        case .nextPage:
            break
        case .none:
          break
        }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
    }
}
