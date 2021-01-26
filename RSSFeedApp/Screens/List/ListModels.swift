//
//  ListModels.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

public struct ListViewModel {
    var news: [NewsViewModel]
}

public struct NewsViewModel {
    var date: Date?
    var title: String?
    var text: String?
}
