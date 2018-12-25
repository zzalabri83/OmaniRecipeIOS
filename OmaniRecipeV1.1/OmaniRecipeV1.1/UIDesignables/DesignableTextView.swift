//
//  DesignableButton.swift
//  OmaniRecipeV1.0
//
//  Created by Training1 on 12/12/18.
//  Copyright © 2018 ITA. All rights reserved.
//

import UIKit


@IBDesignable
public class DesignableTextView: UITextView {
    
    // MARK: - IBInspectable properties
    /// Applies border to the text view with the specified width
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Make the corners rounded with the specified radius
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
/*
 @IBDesignable class DesignableTextField: UITextField {
 
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
 
 }*/
