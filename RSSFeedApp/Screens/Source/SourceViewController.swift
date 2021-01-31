//
//  SourceViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import UIKit

//MARK: Protocols
public protocol SourceViewControllerProtocol: AnyObject {
    func displayData(with viewModel: SourceViewModel)
}

public protocol SourceViewControllerRoutingProtocol: AnyObject {
    
}

public protocol SourceViewControllerViewingProtocol: AnyObject {
    func saveData()
}

public protocol SettingsUpdatingDelegate: AnyObject {
    func didAddNewSource()
}

//MARK: SettingsViewController
public class SourceViewController: UIViewController {
    
    //MARK: Views
    lazy var sourceView = SourceView()
    
    //MARK: Properties
    var presenter: SourcePresenterProtocol?
    var interactor: SourceInteractor?
    var router: SourceRouter?
    var delegate: SettingsUpdatingDelegate?
    
    var viewModel: SourceViewModel?
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if let viewModel = viewModel {
//            configure(with: viewModel)
            sourceView.configure(with: viewModel)
        }
    }
}

extension SourceViewController: SourceViewControllerProtocol {
    public func displayData(with viewModel: SourceViewModel) {
        sourceView.configure(with: viewModel)
        self.viewModel = viewModel
    }
}

extension SourceViewController: SourceViewControllerRoutingProtocol {
    
}

extension SourceViewController: SourceViewControllerViewingProtocol {
    public func saveData() {
        guard let viewModel = viewModel else { return }
        presenter?.saveSource(with: viewModel, completionHandler: {
            [weak self] in
            DispatchQueue.main.async {
                self?.delegate?.didAddNewSource()
                self?.dismiss(animated: true, completion: nil)
            }
        })
    }
}

extension SourceViewController {
    private func setup() {
        sourceView.viewController = self
        view.addSubview(sourceView)
        sourceView.edgesToSuperview()
    }
    
//    private func configure(with viewModel: SourceViewModel) {
//        sourceView.titleTextField.text = viewModel.title
//        sourceView.urlTextField.text = viewModel.url
//        sourceView.switcher.isOn = viewModel.checked
//    }
}
