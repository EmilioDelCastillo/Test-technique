//
//  Main+DataSource.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        let article = articles[indexPath.row]
        
        // Format the title from the HTML data
        let htmlData = Data(article.title.utf8)
        if let attributed = try? NSMutableAttributedString(data: htmlData,
                                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                                           documentAttributes: nil) {
            let font = UIFont.systemFont(ofSize: 18)
            attributed.addAttribute(.font, value: font , range: NSRange(location: 0, length: attributed.length))
            cell.articleTitle.attributedText = attributed
            cell.articleTitle.lineBreakMode = .byTruncatingTail
        } else {
            
            cell.articleTitle.text = article.title
        }
        
        // Format the date from the JSON data
        let date = Date(timeIntervalSince1970: article.pubDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'à' HH:mm"
        
        cell.articleDate.text = dateFormatter.string(from: date)
        
        // While loading the image
        cell.spinner.startAnimating()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let url = URL(string: article.urlImage)!
            let image = try? UIImage(data: Data(contentsOf: url))
            DispatchQueue.main.async {
                cell.articleImage.image = image
                cell.articleImage.contentMode = .scaleAspectFill
                cell.spinner.stopAnimating()
            }
        }
        
        return cell
    }
}
