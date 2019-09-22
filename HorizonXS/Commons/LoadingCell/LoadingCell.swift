//
//  LoadingCell.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let loadingActivity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .medium
        activity.startAnimating()
        return activity
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(loadingActivity)
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal Error")
    }

    func setConstraints() {
        loadingActivity.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingActivity.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
