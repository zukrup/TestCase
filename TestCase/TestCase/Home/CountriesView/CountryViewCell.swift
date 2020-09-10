//
//  RepoViewCell.swift
//  SoftCaseDemo
//
//  Created by musa fedakar on 17.08.2020.
//  Copyright © 2020 musa fedakar. All rights reserved.
//

import UIKit 

class CountryViewCell: UITableViewCell {
 
    @IBOutlet weak var countryNameLabel: MyUILabeLField!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardview()
        // Initialization code
    }
    
    fileprivate func setupCardview() {
        
        self.cardView.layer.cornerRadius = 2.0
        self.cardView.layer.borderWidth = 0.5
        self.cardView.layer.borderColor = UIColor.whiteTintColor(1.0).cgColor
    }
    
    var country:String? = nil {
        didSet {
            if let c = country {
                self.countryNameLabel.text = c
            }
        }
    }
    
}
