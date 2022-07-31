//
//  TrendingRepoListViewController.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import UIKit
import SkeletonView

final class TrendingRepoListViewController: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource, ErrorViewDelegate {

    // MARK: - IBOutlets and variables

    @IBOutlet weak var trendingRepoTableView: UITableView!

    private let viewModel: TrendingRepoListViewModelInputOutput
    private let refreshControl = UIRefreshControl()
    private var errorView: ErrorView?

    // MARK: - LifeCycle Methods

    init(viewModel: TrendingRepoListViewModelInputOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureTableView()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    // MARK: - Private Methods

    private func setupViews() {
        title = viewModel.screenTitle
    }

    private func configureTableView() {
        trendingRepoTableView.register(cellType: TrendingRepositoryTableViewCell.self)
        trendingRepoTableView.refreshControl = refreshControl
        trendingRepoTableView.delegate = self
        trendingRepoTableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }

    private func bind(to viewModel: TrendingRepoListViewModelInputOutput) {
        viewModel.repos.observe(on: self) { [weak self] repos in
            guard let self = self, repos.count > 0 else { return }
            self.refreshControl.endRefreshing()
            if (self.errorView != nil) {
                self.errorView?.removeFromSuperview()
            }
            self.updateItems()
        }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }

    private func updateItems() {
        trendingRepoTableView.reloadData()
    }

    private func updateLoading(_ loading: TrendingRepositoriesListViewModelLoading?) {
        switch loading {
        case .firstPage:
            view.showAnimatedGradientSkeleton()
            updateItems()
        case .nextPage, .none:
            hideSkeletionAnimations()
            updateItems()
        }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        // we can hide refresh control here //
        self.errorView = ErrorView.instanceFromNib()
        self.errorView?.frame = self.view.frame
        self.errorView?.delegate = self
        view.addSubview(errorView!)
    }

    private func hideSkeletionAnimations() {
        view.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
    }

    // MARK: - Selector Methods

    @objc private func pullToRefresh() {
        viewModel.pullToRefresh()
    }

    // MARK: - SkeletonTableView DataSource

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TrendingRepositoryTableViewCell.reuseIdentifier
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.loading.value == .firstPage ? 10 : viewModel.repos.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrendingRepositoryTableViewCell.reuseIdentifier, for: indexPath) as? TrendingRepositoryTableViewCell {
            if viewModel.loading.value == .firstPage {
                cell.contentView.showAnimatedGradientSkeleton()
            } else {
                cell.configureCell(data: viewModel.repos.value[indexPath.row])
            }

            if indexPath.row == viewModel.repos.value.count - 1 {
                viewModel.didLoadNextPage()
            }
            return cell
        }
        return UITableViewCell()
    }

    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.repos.value.count > 0 {
            viewModel.repos.value[indexPath.row].isCollapsed.toggle()
            trendingRepoTableView.reloadData()
        }
    }

    // MARK: - ErrorView Delegate

    func retryButtonTapped() {
        viewModel.retryForError()
    }
}
