//
//  AddIngredientTableViewCell.swift
//  TestUITable
//
//  Created by Zahran on 12/24/18.
//  Copyright © 2018 Zahran. All rights reserved.
//

import UIKit

class AddIngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var txtCell1: UITextField!
    
    public func configure(text: String?, placeholder: String) {
        txtCell1.text = text
        txtCell1.placeholder = placeholder
        
        txtCell1.accessibilityValue = text
        txtCell1.accessibilityLabel = placeholder
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
