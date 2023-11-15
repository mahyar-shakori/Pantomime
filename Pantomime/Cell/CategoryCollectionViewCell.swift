//
//  CategoryCollectionViewCell.swift
//  Pantomime
//
//  Created by Mahyar on 11/13/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configure(with categoryName: String){
        categoryLabel.text = categoryName
    }
}
