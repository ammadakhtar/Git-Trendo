//
//  ErrorView.swift
//  Git-Trendo
//
//  Created by Ammad Akhtar on 30/07/2022.
//

import UIKit
import Lottie

protocol ErrorViewDelegate: AnyObject {
    func retryButtonTapped()
}

final class ErrorView: UIView {

    // MARK: - IBOutlets and variables

    @IBOutlet weak var lottieView: AnimationView!
    @IBOutlet weak var retryButton: UIButton!

    weak var delegate: ErrorViewDelegate?
    var didRetry: (() -> Void)?

    // MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    class func instanceFromNib() -> ErrorView? {
        return UINib(nibName: String(describing: ErrorView.self),
                     bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ErrorView
    }

    // MARK: - Private Methods

    private func setupViews() {
        lottieView.animation = .named("lottie_badNetwork")
        lottieView.loopMode = .loop
        lottieView.play()

        retryButton.layer.cornerRadius = 10
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor.systemGreen.cgColor
    }

    // MARK: - IBActions

    @IBAction func retryButtonTapped() {
        delegate?.retryButtonTapped()
        self.removeFromSuperview()
        didRetry?()
    }
}
