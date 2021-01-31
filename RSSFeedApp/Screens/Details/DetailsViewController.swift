//
//  NewsDetailsViewController.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit
import TinyConstraints

public protocol DetailsViewControllerProtocol: AnyObject {
    
}

public protocol DetailsViewControllerRoutingProtocol: AnyObject {
    
}

public class DetailsViewController: UIViewController {
    
    //MARK: Views
    lazy var titleLabel = UILabel.makeTitleDetailsLabel()
    lazy var dateLabel = UILabel.makeDateDetailsLabel()
    lazy var textLabel = UILabel.makeTextDetailsLabel()
    lazy var stackView = UIStackView.makeVerticalStackView(views: [titleLabel,
                                                                   dateLabel,
                                                                   textLabel])
    lazy var scrollView = UIScrollView.makeUIScrollView(frame: self.view.bounds)
    
    //MARK: Properties
    var presenter: DetailsPresenter?
    var interactor: DetailsInteractor?
    var router: DetailsRouter?
    
    var viewModel: DetailsViewModel
    
    //MARK: Init
    public init(detailsViewModel: DetailsViewModel) {
        self.viewModel = detailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView(with: viewModel)
    }
    
    //MARK: setup
    private func setupView() {
        scrollView.delegate = self
        
        view.backgroundColor = Constants.Colors.backgroundColor
        stackView.backgroundColor = Constants.Colors.backgroundColor
        scrollView.backgroundColor = Constants.Colors.backgroundColor
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        //MARK: Constraints
        titleLabel.width(to: view, multiplier: 0.95)
        dateLabel.width(to: view, multiplier: 0.95)
        textLabel.width(to: view, multiplier: 0.95)
        
        stackView.edgesToSuperview(insets: .top(10) + .left(10) + .bottom(10) + .right(10))
        scrollView.edgesToSuperview()
    }
    
    //MARK: configure
    private func configureView(with viewModel: DetailsViewModel) {
        self.titleLabel.text = viewModel.title
        self.dateLabel.text = viewModel.pubDate?.toString()
        self.textLabel.attributedText = viewModel.text?.convertToAttributedFromHTML()
        self.textLabel.font = Constants.Fonts.textDetailsFont
        self.textLabel.textColor = Constants.Colors.textColor
    }
}

extension DetailsViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
}

extension DetailsViewController: DetailsViewControllerProtocol {
    
}

extension DetailsViewController: DetailsViewControllerRoutingProtocol {
    
}
