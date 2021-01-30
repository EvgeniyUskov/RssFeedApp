//
//  UILabel + Extension.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 27.01.2021.
//


import UIKit

extension UILabel {
    
    //MARK: List view
    static func makeNewsTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.titleListFont
        label.textColor = Constants.Colors.textColor
        label.numberOfLines = 2
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }
    
    static func makeNewsDateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Constants.Fonts.dateListFont
        label.textColor = Constants.Colors.textColor
        return label
    }
    
    static func makeMessageTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = Constants.Fonts.messageTitleFont
        label.textColor = Constants.Colors.textColor
        return label
    }
    
    //MARK: Details view
    static func makeTitleDetailsLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.Fonts.titleDetailsFont
        label.textColor = Constants.Colors.textColor
        return label
    }
    
    static func makeTextDetailsLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.font = Constants.Fonts.textDetailsFont
        label.textColor = Constants.Colors.textColor
        return label
    }
    
    static func makeDateDetailsLabel() -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        
        label.font = Constants.Fonts.dateDetailsFont
        label.textColor = Constants.Colors.textColor
        return label
    }
    
    static func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.lineBreakMode = .byWordWrapping
        
        label.font = Constants.Fonts.dateDetailsFont
        label.textColor = .red
        return label
    }
}
