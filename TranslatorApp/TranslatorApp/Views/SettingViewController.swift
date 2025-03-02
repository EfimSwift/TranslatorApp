//
//  SettingViewController.swift
//  TranslatorApp
//
//  Created by user on 26.02.2025.
//

import UIKit

class SettingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var titleLabel = UILabel()
    private var collectionView: UICollectionView!
    
    let sections = [
        ["Rate Us","Share App","Contact Us"],
        ["Restore Purchases","Privacy Policy","Terms of Use"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0)
        createTitle()
        setupCollectionView()
        setupTapBar()
    }
    
    //MARK: - create tapBar
    private func setupTapBar() {
        let tabBar = CustomTabBar()
        view.addSubview(tabBar)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        //MARK: - tabBar constraint
        NSLayoutConstraint.activate([
            tabBar.heightAnchor.constraint(equalToConstant: 82),
            tabBar.widthAnchor.constraint(equalToConstant: 216),
            tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 750)
        ])
        //MARK: - translatorButton addTarget
        tabBar.translatorButton.addTarget(self, action: #selector(translatorTapped), for: .touchUpInside)
    }
    
    //MARK: - settings collectionView
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(50))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(50))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
            
            return section
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SetingsCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //MARK: - collectionView constraint
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    //MARK: create titleLabel
    func createTitle() {
        titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            //MARK: - titleLabel constraint
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - UICollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SetingsCell
        cell.configure(with: sections[indexPath.section][indexPath.item])
        return cell
    }
    
    //MARK: - selector for translatorButton
    @objc func translatorTapped() {
        navigationController?.popViewController(animated: true)
        
    }
}
