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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageForOutlet: UIImage!
    var imageURLForOutlet: URL!
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
        
        // Load the article image if it hasn't been loaded yet
        if let image = imageForOutlet {
            articleImage.image = image
            self.spinner.stopAnimating()
        } else {
            DispatchQueue.global(qos: .userInteractive).async {
                
                let image = try? UIImage(data: Data(contentsOf: self.imageURLForOutlet))
                DispatchQueue.main.async {
                    self.articleImage.image = image
                    self.articleImage.contentMode = .scaleAspectFill
                    self.spinner.stopAnimating()
                }
            }
        }
        
        articleImage.contentMode = .scaleAspectFill
        articleDate.text = dateForOutlet

    }
    
    @IBAction func dismiss (_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
