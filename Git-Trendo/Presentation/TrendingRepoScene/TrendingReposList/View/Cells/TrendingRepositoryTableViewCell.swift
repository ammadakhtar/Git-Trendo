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
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var roundIconView: UIView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var collapsableStackView: UIStackView!
    
    static let reuseIdentifier = "TrendingRepositoryTableViewCell"

    // MARK: - LifeCycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessibilityIdentifier = AccessibilityIdentifier.reopCellIdentifier
        repoDescriptionLabel.accessibilityIdentifier = AccessibilityIdentifier.repoDescriptionLabelIdentifier
        repoOwnerNameLabel.accessibilityIdentifier = AccessibilityIdentifier.ownerLabelIdentifier
        repoTitleLabel.accessibilityIdentifier = AccessibilityIdentifier.repoTitleLabelIdentifier
        languageLabel.accessibilityIdentifier = AccessibilityIdentifier.repoLanguageLabelIdentifier
        starCountLabel.accessibilityIdentifier = AccessibilityIdentifier.repoStarCountLabel

        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        roundIconView.layer.cornerRadius = roundIconView.frame.height / 2
    }

    override func prepareForReuse() {
        profileImageView.image = nil
    }

    // MARK: - Methods

    func configureCell(data: TrendingRepositoriesListItemViewModel) {
        if let url = URL(string: data.owner.avatarUrl) {
            profileImageView.sd_setImage(with: url)
        }
        repoOwnerNameLabel.text = data.owner.login
        repoTitleLabel.text = data.name
        repoDescriptionLabel.text = data.description
        languageLabel.text = data.language
        starCountLabel.text = "\(data.starsCount)"

        detailContainerView.isHidden = data.isCollapsed
        repoDescriptionLabel.isHidden = data.isCollapsed
        collapsableStackView.isHidden = data.isCollapsed
    }
}
