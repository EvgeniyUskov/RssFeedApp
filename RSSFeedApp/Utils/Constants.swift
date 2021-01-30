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
        static let viewedColor = UIColor(named: "ViewedColor")
        
        static let messageTextColor = UIColor.lightGray
        
        static let dialogBackgroundColor = UIColor.lightGray
    }
    enum Fonts {
        static let messageTitleFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let messageSubtitleFont = UIFont.systemFont(ofSize: 10, weight: .light)
        
        static let titleListFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
        static let dateListFont = UIFont.systemFont(ofSize: 10, weight: .light)
        
        static let titleDetailsFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let dateDetailsFont = UIFont.systemFont(ofSize: 15, weight: .light)
        static let textDetailsFont = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    enum Ids {
        static let newsCellReuseId = "newsCell"
        static let settingsCellReuseId = "settingsCell"
        static let trackCellReuseId = "trackCell"
        static let historyCellReuseId = "historyCell"
    }
    
    enum Urls {
    }
    
    enum Stuff {
        static let noNewsTitleMessage = "Нет новостей"
        static let noNewsSubtitleMessage = "Ваша лента пуста"
        
        static let noSourcesTitleMessage = "Нет источников"
        static let noSourcesSubtitleMessage = "Добавьте источники для получения новостей"
        
        static let addNewTitleDialogText = "Новый Источник"
        static let editTitleDialogText = "Редактирование"
        
        static let rightBarButtonItemText = "Назад"
        static let saveButtonText = "Добавить"
        
        static let isActiveText = "Активный"
        static let sourceTitleText = "Имя:"
        static let urlTitleText = "URL:"
        
        static let titlePlaceholderText = "Название"
        static let urlPlaceholderText = "https://"
        
        static let wrongUrl = "Введите корректный URL адрес"
        static let wrongRss = "По этим адресам нет RSS рассылки"
            static let modelName = "NewsSources"
    }
}
