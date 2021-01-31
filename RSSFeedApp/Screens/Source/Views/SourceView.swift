//
//  SourceView.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import UIKit
import TinyConstraints

class SourceView: UIView {

    //MARK: Views
    //MARK: View Title
    lazy var titleLabel: UILabel = {
        let label = UILabel.makeTitleDetailsLabel()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Source title
    lazy var titleCaptionLabel: UILabel = {
        let label = UILabel.makeTitleDetailsLabel()
        label.text = Constants.Stuff.sourceTitleText
        return label
    }()
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Constants.Stuff.titlePlaceholderText
        textField.autocapitalizationType = .none
        return textField
    }()
    lazy var sourceTitleStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [titleCaptionLabel,
                                                    titleTextField])
        stackView.spacing = 5
        return stackView
    }()
    
    //MARK: Source url
    lazy var errorLabel: UILabel = {
        let label = UILabel.makeErrorLabel()
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    lazy var urlCaptionLabel: UILabel = {
        let label = UILabel.makeTitleDetailsLabel()
        label.text = Constants.Stuff.urlTitleText
        return label
    }()
    lazy var urlTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Constants.Stuff.urlPlaceholderText
        textField.autocapitalizationType = .none
        return textField
    }()
    lazy var sourceUrlStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [urlCaptionLabel,
                                                                    urlTextField])
        stackView.spacing = 5
        return stackView
    }()
    lazy var sourceUrlAndErrorStackView: UIStackView = {
        let stackView = UIStackView.makeVerticalStackView(views: [errorLabel,
                                                                  sourceUrlStackView])
        stackView.spacing = 5
        return stackView
    }()
    
    //MARK: Enabled
    lazy var ckeckedLabel: UILabel = {
        let label = UILabel.makeTitleDetailsLabel()
        label.text = Constants.Stuff.isActiveText
        return label
    }()
    lazy var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    lazy var switcherStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [spacerView,
                                                                    switcher])
        stackView.alignment = .center
        return stackView
    }()
    lazy var checkedStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [ckeckedLabel,
                                                                    switcherStackView])
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: Button
    lazy var saveButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = Constants.Colors.textColor
        button.tintColor = Constants.Colors.backgroundColor
        button.addTarget(self, action: #selector(saveSource), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Stuff.saveButtonText, for: .normal)
        button.setTitleColor(Constants.Colors.backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
        return button
    }()
    
    //MARK: Global StackView
    lazy var globalStackView: UIStackView = {
        let stackView = UIStackView.makeVerticalStackView(views: [titleLabel,
                                                                  checkedStackView,
                                                                  sourceTitleStackView,
                                                                  sourceUrlAndErrorStackView,
                                                                  saveButton
        ])
        return stackView
    }()
    
    //MARK: Properties
    var sourceViewModel: SourceViewModel?
    var viewController: SourceViewControllerViewingProtocol?
    
    //MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        saveButton.height(44)
        addSubview(globalStackView)
        globalStackView.top(to: self, offset: 20)
        globalStackView.left(to: self, offset: 20)
        globalStackView.right(to: self, offset: -20)
        spacerView.width(to: switcherStackView, multiplier: 0.57)
    }
    
    func configure(with viewModel: SourceViewModel) {
        errorLabel.isHidden = true
        if viewModel.url == nil {
            titleLabel.text = Constants.Stuff.addNewTitleDialogText
            saveButton.setTitle(Constants.Stuff.saveButtonText, for: .normal)
        }
        else {
            titleLabel.text = Constants.Stuff.editTitleDialogText
            saveButton.setTitle(Constants.Stuff.editButtonText, for: .normal)
        }
        
        titleTextField.text = viewModel.title
        urlTextField.text = viewModel.url
        switcher.isOn = viewModel.checked
        sourceViewModel = viewModel
        
    }
        
    @objc
    private func saveSource() {
        if validateUrl() {
            errorLabel.isHidden = true
            fillSource()
            viewController?.saveData()
        }
        else {
            errorLabel.text = Constants.Stuff.wrongUrl
            errorLabel.isHidden = false
        }
    }
    
    private func fillSource() {
        sourceViewModel?.title = titleTextField.text
        sourceViewModel?.url = urlTextField.text
        sourceViewModel?.checked = switcher.isOn
        
        sourceViewModel?.source.title = titleTextField.text
        sourceViewModel?.source.url = urlTextField.text
        sourceViewModel?.source.checked = switcher.isOn
    }
    
    private func validateUrl() -> Bool {
        guard let text = urlTextField.text,
              let _ = URL(string: text) else {
            return false
        }
        return true
    }
}
