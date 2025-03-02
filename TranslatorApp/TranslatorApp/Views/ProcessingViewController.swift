//
//  ProcessingViewController.swift
//  TranslatorApp
//
//  Created by user on 26.02.2025.
//

import UIKit

class ProcessingViewController: UIViewController {
    var selectedAnimalImage: UIImage?
    let imageView = UIImageView()
    let loadingLabel = UILabel()
    var selectedAnimalType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0)
        setupUI()
        setupTapBar()
        //MARK: - timer to go to the settings screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToResultScreen()
        }
    }
    
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
    }
    func setupUI() {
        //MARK: - settings animal image
        imageView.image = selectedAnimalImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        //MARK: - settings loadingLabel
        loadingLabel.text = "Process of translation..."
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            //MARK: - loadingLabel constraint
            loadingLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -20),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //MARK: animal image constraint
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 184),
            imageView.heightAnchor.constraint(equalToConstant: 184),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 596)
        ])
    }
    
    //MARK: - transfer of the selected animal
    func navigateToResultScreen() {
        let resultVC = ResultViewController()
        resultVC.selectedAnimalImage = selectedAnimalImage
        resultVC.selectedAnimalType = selectedAnimalType
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

