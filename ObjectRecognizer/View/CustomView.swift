//
//  CustomView.swift
//  ObjectRecognizer
//
//  Created by Staham Nguyen on 08/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func awakeFromNib() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.5
        layer.cornerRadius = frame.height / 2
    }
}
