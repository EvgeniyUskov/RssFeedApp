//
//  String + Extension.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 27.01.2021.
//

import UIKit

extension String {
    func convertToAttributedFromHTML() -> NSAttributedString? {
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        
        if let data = self.data(using: .unicode, allowLossyConversion: true),
           let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attrStr
        }
        return attributedText
    }
}
