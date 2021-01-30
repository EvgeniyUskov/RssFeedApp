//
//  DetailsModels.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

public struct DetailsViewModel {
    var pubDate: Date?
    var title: String?
    var text: String?
    
    init(newsViewModel: NewsViewModel) {
        self.pubDate = newsViewModel.pubDate
        self.title = newsViewModel.title
        self.text = newsViewModel.text
    }
}
