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
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        titleLabel.adjustsFontSizeToFitWidth = true
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
        initialHeight = self.initialHeight ?? self.frame.height
        let scaledFont = (23 * self.frame.height / initialHeight)
        let fontSize = scaledFont < 18 ? 18 : scaledFont > 27 ? 27 : scaledFont
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
    }

    func setupControls() {
        self.backgroundColor = UIColor.headerColor
        self.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
