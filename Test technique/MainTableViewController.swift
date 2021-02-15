//
//  MainTableViewController.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var articles = [Article]()
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
}
