//
//  ErrorView.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/22/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

protocol ErroViewDelegate: class {
    func didTapTryAgain(in errorView: ErrorView)
}

class ErrorView: UIView {

    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var tryAgainButton: UIButton!

    var contentView: UIView?
    weak var delegate: ErroViewDelegate?

    func setTitleTryAgainButton(_ title: String) {
        self.tryAgainButton.setTitle(title, for: .normal)
    }

    func setError(_ description: String) {
        self.errorLabel.text = description
    }

    func setErrorTextColor(_ color: UIColor) {
        self.errorLabel.textColor = color
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    // MARK: - Load xib
    private func xibSetup() {
        let contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        self.contentView = contentView
        self.setTitleTryAgainButton("RETRY".localized)
        self.tryAgainButton.layer.masksToBounds = true
        self.tryAgainButton.layer.cornerRadius = 4
    }

    @IBAction private func tryAgain(_ sender: Any) {
        delegate?.didTapTryAgain(in: self)
    }
}
