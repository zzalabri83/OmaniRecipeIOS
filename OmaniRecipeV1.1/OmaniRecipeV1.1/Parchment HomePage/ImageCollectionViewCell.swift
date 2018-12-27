//
//  Image2CollectionViewCell.swift
//  UnplashExample
//
//  Created by Zahran on 12/27/18.
//  Copyright © 2018 Martin Rechsteiner. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //@IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    static let reuseIdentifier: String = "ImageCellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.text = "Title2"
        lblTitle = label
        
        let imageView = UIImageView(image: UIImage(named: "coffee-1"))
        //imageCell.image = UIImage(named: "coffee-1")
        imageCell = imageView
        contentView.clipsToBounds = true
        contentView.addSubview(imageCell)
        contentView.constrainToEdges(imageCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ image: UIImage) {
        imageCell.image = image
    }
//    func setImage(_ imageView: UIImageView) {
//        imageCell = imageView
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
