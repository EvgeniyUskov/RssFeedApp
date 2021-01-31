//
//  UINavigationBar + Extension.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import UIKit

extension UINavigationBar {
    static func getAppearance() -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = Constants.Colors.backgroundColor
        if let textColor = Constants.Colors.textColor {
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: textColor]
        }
        return navBarAppearance
    }
}
