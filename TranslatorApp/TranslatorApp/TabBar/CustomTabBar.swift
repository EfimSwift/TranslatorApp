//
//  CustomTabBar.swift
//  TranslatorApp
//
//  Created by user on 26.02.2025.
//

import UIKit

class CustomTabBar: UIView {
    
    //MARK: - create and settings tranlsatorButton
    public let translatorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Translator", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setImage(UIImage(systemName: "bubble.left.and.bubble.right"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: -45)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: -40, bottom: 0, right: 0)
        return button
    }()
    
    //MARK: - create and settings clickerButton
    public let clickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clicker", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: -60)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: creating stack view with translatorButton and clickerButton
    public func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        //MARK: - made translatorButton for stackView
        let translatorStack = UIStackView(arrangedSubviews: [translatorButton])
        translatorStack.axis = .vertical
        translatorStack.alignment = .center
        translatorStack.spacing = 5
        //MARK: made clickerButton for stackView
        let clickerStack = UIStackView(arrangedSubviews: [clickerButton])
        clickerStack.axis = .vertical
        clickerStack.alignment = .center
        clickerStack.spacing = 5
        //MARK: - made stackView for clickerButton and translatorButton
        let stackView = UIStackView(arrangedSubviews: [translatorButton, clickerButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //MARK: - stackView constraint
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
