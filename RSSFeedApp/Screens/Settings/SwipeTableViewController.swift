//
//  SwipeTableViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 30.01.2021.
//

import UIKit
import SwipeCellKit

public class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var cell: UITableViewCell?

    public override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 80.0
    }

    //TableView Datasource Methods
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Ids.settingsCellReuseId, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    public func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    public func updateModel(at indexPath: IndexPath) {
    }

}