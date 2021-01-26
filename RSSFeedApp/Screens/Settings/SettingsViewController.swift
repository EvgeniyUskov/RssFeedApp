//
//  SettingsViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SettingsViewControllerProtocol: AnyObject {
    
}

public protocol SettingsViewControllerRoutingProtocol: AnyObject {
    
}

//MARK: SettingsViewController
public class SettingsViewController: UITableViewController {
    
    //MARK: Properties
    weak var presenter: SettingsPresenterProtocol?
    weak var interactor: SettingsInteractor?
    weak var router: SettingsRouter?
    
    var viewModel = SettingsViewModel(sources: [])
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: SettingsViewControllerProtocol Implementation
extension SettingsViewController: SettingsViewControllerProtocol {
    
}

//MARK: SettingsViewControllerProtocol Implementation
extension SettingsViewController: SettingsViewControllerRoutingProtocol {
    
}
