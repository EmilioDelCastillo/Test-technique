//
//  ArticleCell.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleDate: UILabel!
    
    
    override func prepareForReuse() {
        // When dequeuing, the image is kept.
        articleImage.image = nil
    }
    
}
