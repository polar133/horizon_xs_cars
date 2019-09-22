//
//  LoadingView.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/22/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private weak var contentView: UIView?
    @IBOutlet private weak var imageLoading: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Inits
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    private func xibSetup() {
        let contentView = loadViewFromNib()
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        self.contentView = contentView
        runSpinAnimationOnView(imageLoading, duration: 60, rotations: 360)

    }

    func willEnterForegroundNotification() {
        runSpinAnimationOnView(imageLoading, duration: 60, rotations: 360)
    }

    // MARK: - Public

    public func startLoading() {
        DispatchQueue.main.async {
            self.runSpinAnimationOnView(self.imageLoading, duration: 60, rotations: 360)
        }
    }

    public func endLoading() {
        DispatchQueue.main.async {
            self.imageLoading.layer.removeAllAnimations()
            self.removeFromSuperview()
        }
    }

    public func setDescription(_ description: String) {
        descriptionLabel.text = description
    }

    public func backgroundColor(color: UIColor) {
        contentView?.backgroundColor = color
    }

    // MARK: - Private

    private func runSpinAnimationOnView(_ view: UIView, duration: Double, rotations: Double) {
        let keyPath = "transform.rotation"
        view.layer.removeAnimation(forKey: keyPath)
        let rotationAtStart = view.layer.value(forKeyPath: keyPath) as? Double ?? 0
        view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat(rotations), 0, 0, 1)
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.fromValue = rotationAtStart
        animation.repeatCount = Float.infinity
        animation.toValue = rotationAtStart + rotations
        view.layer.add(animation, forKey: keyPath)
    }
}
