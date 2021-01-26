//
//  NewsDetailsViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit
public protocol DetailsViewControllerProtocol: AnyObject {
    
}

public protocol DetailsViewControllerRoutingProtocol: AnyObject {
    
}

public class DetailsViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailsViewController: DetailsViewControllerProtocol {
    
}
