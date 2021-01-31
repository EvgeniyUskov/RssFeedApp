//
//  DetaialsViewControllerTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import UIKit
@testable import RSSFeedApp

//MARK: DetailsViewControllerStub
public class DetailsViewControllerStub: UIViewController {
    
    //MARK: Properties
    var viewModel: DetailsViewModel?
    
    public var router: DetailsRouterProtocol?
    public var interactor: DetailsInteractorProtocol?
    public var presenter: DetailsPresenterProtocol?
    
    init(viewModel: DetailsViewModel) {
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

//MARK: DetailsViewControllerProtocol implementation protocols
extension DetailsViewControllerStub: DetailsViewControllerProtocol {
}

//MARK: DetailsViewControllerRoutingProtocol implementation protocols
extension DetailsViewControllerStub: DetailsViewControllerRoutingProtocol {

}
