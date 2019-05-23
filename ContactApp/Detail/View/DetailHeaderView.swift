//
//  DetailHeaderView.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        return titleLabel
    }()

    var initialHeight: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupControls()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateHeader(firstName: String, lastName: String) {
        titleLabel.text = "\(firstName) \(lastName)"
    }

    override func layoutSubviews() {
        if self.initialHeight == nil {
            initialHeight = self.frame.height
        }

        let scaledFont = (25 * self.frame.height / initialHeight)
        let fontSize = scaledFont < 18 ? 18 : scaledFont > 30 ? 30 : scaledFont
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
    }

    func setupControls() {
        self.backgroundColor = UIColor.headerColor
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
}
