//
//  ResultViewController.swift
//  TranslatorApp
//
//  Created by user on 28.02.2025.
//
import UIKit

class ResultViewController: UIViewController {
    var titleLabel = UILabel()
    var selectedAnimalImage: UIImage?
    var selectedAnimalType: String?
    let imageView = UIImageView()
    let speechBubble = SpeechBubbleView(text: "")
    let repeatButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let catResponsesArray = [
        "I'm hungry, feed me!",
        "You were gone for a long time, I missed you",
        "How are you doing?",
        "What's new with you?"
    ]
    let dogResponsesArray = [
        "What are you doing human?",
        "I want to walk!",
        "Let's throw the ball to me and I'll bring it to you?",
        "Do you think your girlfriend is more loyal to me?"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0)
        setupUI()
        //MARK: - start a 10 second timer to replace the SpeechBubbleView with a "Repeat" button
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.replaceSpeechBubbleWithRepeatButton()
        }
    }
    
    func setupUI() {
        //MARK: - titleLabel
        titleLabel.text = "Result"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        //MARK: - set the text depending on the animal
        if selectedAnimalType == "cat3D" {
            speechBubble.text = randomResponse(from: catResponsesArray)
        } else if selectedAnimalType == "dog3D" {
            speechBubble.text = randomResponse(from: dogResponsesArray)
        } else {
            speechBubble.text = "Неизвестное животное"
        }
        //MARK: - settings SpeechBubbleView
        speechBubble.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speechBubble)
        
        //MARK: - set image animal
        imageView.image = selectedAnimalImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        //MARK: - settings backButton
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.tintColor = .black
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 15
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.lightGray.cgColor
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        //MARK: - settings repeatButton
        repeatButton.setTitle("Repeat", for: .normal)
        repeatButton.setTitleColor(.black, for: .normal)
        repeatButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        repeatButton.backgroundColor = UIColor(red: 0.85, green: 0.9, blue: 1.0, alpha: 1.0)
        repeatButton.layer.cornerRadius = 16
        //MARK: - add icon arrow.clockwise
        repeatButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        repeatButton.tintColor = .black
        repeatButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        repeatButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
        view.addSubview(repeatButton)
        repeatButton.isHidden = true
        
        NSLayoutConstraint.activate([
            //MARK: - titleLabel constraint
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //MARK: - backButton constraint
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            //MARK: - SpeechBubbleView constraint
            speechBubble.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            speechBubble.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speechBubble.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            speechBubble.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            //MARK: repeatButton constraint
            repeatButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            repeatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            repeatButton.heightAnchor.constraint(equalToConstant: 44),
            //MARK: - pet constraint
            imageView.topAnchor.constraint(equalTo: speechBubble.bottomAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 184),
            imageView.heightAnchor.constraint(equalToConstant: 184),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 596)
        ])
    }
    
    //MARK: - random responses animal
    func randomResponse(from responses: [String]) -> String {
        guard !responses.isEmpty else { return "Неизвестное животное" }
        let randomIndex = Int.random(in: 0..<responses.count)
        return responses[randomIndex]
    }
    
    //MARK: - Method for replacing SpeechBubbleView with the "Repeat" button
    func replaceSpeechBubbleWithRepeatButton() {
        speechBubble.isHidden = true
        repeatButton.isHidden = false
        imageView.topAnchor.constraint(equalTo: repeatButton.bottomAnchor, constant: 100).isActive = true
    }
    
    //MARK: - selector backButton
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - selector repeatButton
    @objc func repeatButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
