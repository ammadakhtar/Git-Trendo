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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Private Methods

    private func setupViews() {
       // guard let errorView = self.fromNib(nibName: "ErrorView") else { return }
        let errorView = ErrorView.loadFromXib(withOwner: self)
        errorView.frame = self.bounds
        self.addSubview(errorView)

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
    }
}
