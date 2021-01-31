//
//  NewsCell.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 25.01.2021.
//

import UIKit

public class NewsCell: UITableViewCell {
    
    //MARK: Properties
    lazy var titleLabel = UILabel.makeNewsTitleLabel()
    lazy var dateLabel = UILabel.makeNewsDateLabel()
    lazy var stackView = UIStackView.makeVerticalStackView(views: [dateLabel,
                                                                     titleLabel])
    //MARK: Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: Setup
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        selectionStyle = .none
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            
            stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            stackView.heightAnchor.constraint(equalToConstant: 64),
            
        ])
    }

    //MARK: Configure
    public func configure(with viewModel: NewsViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.pubDate?.toString()
    }

    public func markAsViewed() {
        titleLabel.textColor = Constants.Colors.viewedColor
    }
}
