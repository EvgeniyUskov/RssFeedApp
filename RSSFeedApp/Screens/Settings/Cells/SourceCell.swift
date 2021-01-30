//
//  SourceCell.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import UIKit

class SourceCell: UITableViewCell {

    //MARK: Properties
    lazy var titleLabel = UILabel.makeNewsTitleLabel()
    lazy var urlLabel = UILabel.makeNewsDateLabel()
    lazy var globalStackView = UIStackView.makeVerticalStackView(views: [titleLabel,
                                                                   urlLabel])
    
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
    
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        selectionStyle = .none
        addSubview(globalStackView)
        
        NSLayoutConstraint.activate([
            globalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            globalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            globalStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20),
            globalStackView.heightAnchor.constraint(equalToConstant: 64),
                                        
           // titleLabel.width(to: stackView, multiplier: 0.95)
        ])
    }
    
    public func configure(with viewModel: SourceViewModel) {
        titleLabel.text = viewModel.title
        urlLabel.text = viewModel.url
    }

    public func markAsViewed() {
        titleLabel.textColor = Constants.Colors.viewedColor
    }

}
