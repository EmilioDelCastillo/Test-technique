//
//  Main+Navigation.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

extension MainTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArticle" {
            
            if let articleVC = (segue.destination as? ArticleViewController) {
                
                let cell = sender as! ArticleCell
                let index = tableView.indexPath(for: cell)
                let article = articles[index!.row]
                
                articleVC.contentsForOutlet = article.description
                articleVC.imageForOutlet = cell.articleImage.image
                articleVC.dateForOutlet = cell.articleDate.text
                articleVC.titleForOutlet = cell.articleTitle.text
            }
        }
    }
}
