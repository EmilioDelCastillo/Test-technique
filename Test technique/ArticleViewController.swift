//
//  ArticleViewController.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var articleScrollView: UIScrollView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleContents: UITextView!
    
    var imageForOutlet: UIImage!
    var titleForOutlet: String!
    var dateForOutlet: String!
    var contentsForOutlet: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font: UIFont = .preferredFont(forTextStyle: .body)
        
        let data = Data(contentsForOutlet.utf8)
        if let attributed = try? NSMutableAttributedString(data: data,
                                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                                           documentAttributes: nil) {
            attributed.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributed.length))
            articleContents.attributedText = attributed
            
        } else {
            articleContents.text = contentsForOutlet
        }
        
        articleTitle.text = titleForOutlet
        articleImage.image = imageForOutlet
        articleImage.contentMode = .scaleAspectFill
        articleDate.text = dateForOutlet

    }
    
    @IBAction func dismiss (_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
