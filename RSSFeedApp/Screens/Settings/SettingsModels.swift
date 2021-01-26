//
//  SettingsModels.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 26.01.2021.
//

import Foundation

public struct SettingsViewModel {
    var sources: [SourceViewModel]
}

public struct SourceViewModel {
    var source: RssSource
    
    var url: String?
    var title: String?
    var checked: Bool
}

