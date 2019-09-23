//
//  ModelCell.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

class ModelCell: UITableViewCell {

    // MARK: - Properties
    static var nibName: String {
        return String(describing: self)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var avatarView: UIView!
    @IBOutlet private weak var avatarLabel: UILabel!

    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configCell(viewModel: ModelViewModel) {
        self.titleLabel.text = viewModel.name
        self.avatarLabel.text = "\(viewModel.name.first ?? " ")"
        self.titleLabel.textColor = UIColor.appColor(viewModel.fontColor)
        self.cardView.backgroundColor = UIColor.appColor(viewModel.backgroundColor)
        self.avatarView.backgroundColor = UIColor.appColor(viewModel.fontColor)
        self.avatarLabel.textColor = UIColor.appColor(viewModel.backgroundColor)
        self.cardView.layer.borderColor = UIColor.appColor(viewModel.borderColor)?.cgColor
        self.cardView.layer.borderWidth = 1
        self.cardView.layer.cornerRadius = 8
        self.avatarView.layer.cornerRadius = 23
    }

}
