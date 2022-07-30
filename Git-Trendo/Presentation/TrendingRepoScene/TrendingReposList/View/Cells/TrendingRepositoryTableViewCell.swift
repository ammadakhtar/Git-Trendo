//
//  TrendingRepositoryTableViewCell.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 29/07/2022.
//

import UIKit
import SDWebImage

final class TrendingRepositoryTableViewCell: UITableViewCell {

    // MARK: - IBOutlets and variables

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var repoOwnerNameLabel: UILabel!
    @IBOutlet weak var repoTitleLabel: UILabel!

    static let reuseIdentifier = "TrendingRepositoryTableViewCell"

    // MARK: - LifeCycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }

    // MARK: - Methods

    func configureCell(data: TrendingRepositoriesListItemViewModel) {
        if let url = URL(string: data.owner.avatarUrl) {
            profileImageView.sd_setImage(with: url)
        }
        repoOwnerNameLabel.text = data.owner.login
        repoTitleLabel.text = data.name
    }
}
