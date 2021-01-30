//
//  DetailsPresenter.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

//MARK: Protocols
public protocol DetailsPresenterProtocol: AnyObject {
    
}

public class DetailsPresenter {
    //MARK: Properties
    weak var viewController: DetailsViewControllerProtocol?
    
    //MARK: Init
    public init(viewController: DetailsViewControllerProtocol) {
        self.viewController = viewController
    }
    
//    private func makeAttributedString(fromString html: String) {
//        let data = Data(html.utf8)
//        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//            yourLabel.attributedText = attributedString
//        }
//    }
}

//MARK: DetailsPresenterProtocol Implementation
extension DetailsPresenter: DetailsPresenterProtocol {
    
}
