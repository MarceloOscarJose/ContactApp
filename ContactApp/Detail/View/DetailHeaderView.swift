//
//  DetailHeaderView.swift
//  ContactApp
//
//  Created by Marcelo José on 23/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
        return containerView
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        titleLabel.adjustsFontSizeToFitWidth = true
        return titleLabel
    }()

    var initialHeight: CGFloat!
    var currentFontSize: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func updateHeader(firstName: String, lastName: String) {
        titleLabel.text = "\(firstName) \(lastName)"
        setupControls()
        currentFontSize = titleLabel.font.pointSize
    }

    override func layoutSubviews() {
        initialHeight = self.initialHeight ?? self.frame.height
        let scaledFont = (currentFontSize * self.frame.height / initialHeight)
        let fontSize = scaledFont < 18 ? 18 : scaledFont > currentFontSize ? currentFontSize : scaledFont
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
    }

    func setupControls() {
        self.backgroundColor = UIColor.headerColor

        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(titleLabel)
        self.addSubview(containerView)

        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
}
