//
//  DesignableButton.swift
//  OmaniRecipeV1.1
//
//  Created by Training1 on 12/16/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {
    
    @IBInspectable var borderwidth: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderwidth
        }
    }
    
    @IBInspectable var bordercolor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = bordercolor.cgColor
        }
    }
    
    @IBInspectable var cornerradius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerradius
        }
    }
    
}
