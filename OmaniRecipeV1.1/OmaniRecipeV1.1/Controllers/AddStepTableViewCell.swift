//
//  AddStepTableViewCell.swift
//  TestUITable
//
//  Created by Zahran on 12/24/18.
//  Copyright © 2018 Zahran. All rights reserved.
//

import UIKit

class AddStepTableViewCell: UITableViewCell {

    @IBOutlet weak var txtCell2: UITextView!
    
    
    public func configure(text: String?, placeholder: String) {
        txtCell2.text = text
        //txtCell2.placeholder = placeholder
        
        txtCell2.accessibilityValue = text
        //txtCell2.accessibilityLabel = placeholder
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
