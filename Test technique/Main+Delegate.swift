//
//  Main+Delegate.swift
//  Test technique
//
//  Created by Emilio Del Castillo on 15/02/2021.
//

import UIKit

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toArticle", sender: tableView.cellForRow(at: indexPath))
    }
}
