//
//  SourceViewControllerStub.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import UIKit
@testable import RSSFeedApp

public class SourceViewControllerStub: UIViewController {
    
    //MARK: Properties
    var viewModel: SourceViewModel?
    
    public var router: SourceRouterProtocol?
    public var interactor: SourceInteractorProtocol?
    public var presenter: SourcePresenterProtocol?
    
    init(viewModel: SourceViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: SourcesViewControllerProtocol implementation methods
extension SourceViewControllerStub: SourceViewControllerProtocol {
    public func displayData(with viewModel: SourceViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: SourceViewControllerViewingProtocol implementation methods
extension SourceViewControllerStub: SourceViewControllerViewingProtocol {
    public func saveData() {
        guard let viewModel = viewModel else { return }
        presenter?.saveSource(with: viewModel, completionHandler: {
        })
    }
}

//MARK: SourcesViewControllerRoutingProtocol implementation methods
extension SourceViewControllerStub: SourceViewControllerRoutingProtocol {

}
