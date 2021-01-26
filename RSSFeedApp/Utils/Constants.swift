//
//  Constants.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

enum Constants {
    
    enum Colors {
        static let backgroundColor = UIColor(named: "BgColor")
        static let textColor = UIColor(named: "TextColor")
    }
    
    enum Ids {
        static let newsCellReuseId = "newsCell"
        static let collectionHeaderId = "collectionHeader"
        static let infoCellReuseId = "infoCell"
        static let trackCellReuseId = "trackCell"
        static let historyCellReuseId = "historyCell"
    }
    
    enum Urls {
        static let tracksUrl = "https://itunes.apple.com/search?term="
        static let tracksUrlSuffix = "&limit=25"
        static let albumsUrl = "https://itunes.apple.com/lookup?id="
        static let albumsUrlSuffix = "&entity=album"
    }
    
    enum Stuff {
        static let searchPlaceholderText = "Artist"
        static let headerText = "Albums"
        static let tracksHeaderText = "Tracks:"
        static let dragDownImage = UIImage(named: "Drag Down")
    }
}
