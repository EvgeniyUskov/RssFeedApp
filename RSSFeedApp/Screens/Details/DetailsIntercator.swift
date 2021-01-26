//
//  DetailsIntercator.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

//MARK: Protocols
public protocol DetailsInteractorProtocol: AnyObject {
    
}

//MARK: DetailsInteractor
public class DetailsInteractor {
    //MARK: Properties
    weak var presenter: DetailsPresenter?
    var storageManager: SourceStorageProtocol?
    
    //MARK: Init
    public init(presenter: DetailsPresenter?, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.storageManager = storageManager
    }
}

//MARK: DetailsInteractorProtocol implementation
extension DetailsInteractor: DetailsInteractorProtocol {
    
}

