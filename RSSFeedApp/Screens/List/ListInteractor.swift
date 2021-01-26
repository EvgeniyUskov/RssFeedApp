//
//  ListViewControllerInteractor.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

//MARK: Protocols
public protocol ListInteractorProtocol: AnyObject {
    
}

//MARK: ListInteractor
public class ListInteractor {
    //MARK: Properties
    weak var presenter: ListPresenter?
    var storageManager: SourceStorageProtocol?
    
    //MARK: Init
    public init(presenter: ListPresenter?, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.storageManager = storageManager
    }
}

//MARK: ListInteractorProtocol implementation
extension ListInteractor: ListInteractorProtocol {
    
}
