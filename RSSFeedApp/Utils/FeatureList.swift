//
//  FeatureList.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import Foundation

public class FeatureList {

    public struct FeatureFlag: Codable {
        let rssUrls: [String]

        private enum CodingKeys: String, CodingKey {
            case rssUrls = "RssUrls"
        }
    }

    private static let plistName: String = "FeatureList"
    let featureFlag: FeatureFlag!

    init() {
        do {
            let propertiesDecoder = PropertyListDecoder()
            let data = try? Data(
                contentsOf: Bundle.main.url(forResource: FeatureList.plistName, withExtension: "plist")!)
            featureFlag = try? propertiesDecoder.decode(FeatureFlag.self, from: data!)
        }
    }
}

