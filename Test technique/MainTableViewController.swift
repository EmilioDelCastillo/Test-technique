//
//  MainTableViewController.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private var articles = [Article]()
    private let url = "https://www.skiplan.pro/vincent/test-technique/flux.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refresh()
    }
    
    @objc private func refresh(){
        asyncFunc(urlString: url) { (news, error) in
            if error != nil {
                let alert = UIAlertController(title: "Network error", message: "Couldn't load the articles", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            } else {
                self.articles = (news?.data)!
                DispatchQueue.main.async {
                    print(self.articles.count)
                    self.tableView.reloadData()
                }
            }
        }
        refreshControl?.endRefreshing()
    }
    
    private func asyncFunc(urlString: String, completion: @escaping (NewsFeed?, Error?) -> Void ){
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                completion(nil, error)
            } else {
                if let myData = data {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(NewsFeed.self, from: myData) {
                        completion(json, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
            
        }.resume()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        let article = articles[indexPath.row]
        
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
        
        
        let date = Date(timeIntervalSince1970: article.pubDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy 'à' HH:mm"
        cell.articleDate.text = dateFormatter.string(from: date)
        
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

    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toArticle", sender: tableView.cellForRow(at: indexPath))
    }
    
    
    
    // MARK: - Navigation

    
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
