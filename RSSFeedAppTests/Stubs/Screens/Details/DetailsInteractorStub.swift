//
//  DetailsInteractorTests.swift
//  RSSFeedAppTests
//
//  Created by Evgeniy Uskov on 31.01.2021.
//

import Foundation
@testable import RSSFeedApp

public class DetailsInteractorStub {
    //MARK: Properties
    var presenter: DetailsPresenterProtocol?

    private var networkManager: NetworkManagerProtocol?
    private var storageManager: SourceStorageProtocol?
    
    //MARK: Init metods
    public init(presenter: DetailsPresenterProtocol, networkManager: NetworkManagerProtocol, storageManager: SourceStorageProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
        self.storageManager = storageManager
    }
    
}

//MARK: SearchInteractorProtocol implementation methods
extension DetailsInteractorStub: DetailsInteractorProtocol{

}
