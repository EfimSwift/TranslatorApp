//
//  SetingsCell.swift
//  TranslatorApp
//
//  Created by user on 27.02.2025.
//

import UIKit

class SetingsCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - create CollectionViewCell
    private func setupUI() {
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 12
        //MARK: - create titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        //MARK: - create arrowImage
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .black
        arrowImageView.contentMode = .scaleAspectFit
        //MARK: create stackView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, arrowImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            //MARK: - stackView constraint
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            //MARK: arrowImage constraint
            arrowImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: - creating configurations to update text in cells
    func configure(with title: String) {
        titleLabel.text = title
    }
}
