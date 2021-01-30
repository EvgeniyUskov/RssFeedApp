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
    var pubDate: Date?
    var title: String?
    var text: String?
}

extension NewsViewModel: Comparable {
    public static func < (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        guard let lhsDate = lhs.pubDate, let rhsDate = rhs.pubDate else {
            return false
        }
        return lhsDate < rhsDate
    }
    
    public static func <= (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        guard let lhsDate = lhs.pubDate, let rhsDate = rhs.pubDate else {
            return false
        }
        return lhsDate <= rhsDate
    }
    
    public static func > (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        guard let lhsDate = lhs.pubDate, let rhsDate = rhs.pubDate else {
            return false
        }
        return lhsDate > rhsDate
    }
    
    public static func >= (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        guard let lhsDate = lhs.pubDate, let rhsDate = rhs.pubDate else {
            return false
        }
        return lhsDate >= rhsDate
    }
    
    public static func == (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        return lhs.pubDate == rhs.pubDate
    }
    
}

