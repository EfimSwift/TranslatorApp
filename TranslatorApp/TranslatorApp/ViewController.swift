import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var titleLabel = UILabel()
    let modeButton = UIButton()
    let humanLabel = UILabel()
    let petLabel = UILabel()
    let switchIcon = UIImageView()
    var startSpeakButton = UIButton()
    var recordingImageView = UIImageView()
    var modeSegmentControl = UISegmentedControl()
    var imagePet = UIImageView()
    let customTabBar = CustomTabBar()
    var settingViewController = SettingViewController()
    var selectedAnimalImage: UIImage?
    
    var isHumanToPet = true
    var isRecording = false
    private var isHumanOnLeft = true
    
    private var humanLabelLeftConstraint: NSLayoutConstraint?
    private var humanLabelRightConstraint: NSLayoutConstraint?
    private var petLabelRightConstraint: NSLayoutConstraint?
    private var petLabelLeftConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0)
        
        createTitleLabel()
        setupModeButton()
        createStartButton()
        createModeSegmentControl()
        createImageView()
        setupTabBar()
        createConstraints()
    }
    
    //MARK: - Custom TabBar
    private func setupTabBar() {
        view.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //MARK: - customTabBar constraint
            customTabBar.heightAnchor.constraint(equalToConstant: 82),
            customTabBar.widthAnchor.constraint(equalToConstant: 216),
            customTabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customTabBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 750)
        ])
        
        //MARK: - cliclerButton addTarget
        customTabBar.clickerButton.addTarget(self, action: #selector(clickerTapped), for: .touchUpInside)
    }
    
    //MARK: - Create titleLabel
    func createTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Translator"
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
    }
    
    //MARK: - Create modeButton
    func setupModeButton() {
        modeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modeButton)
        //MARK: - settings humanLabel
        humanLabel.text = "HUMAN"
        humanLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        humanLabel.textColor = .black
        humanLabel.translatesAutoresizingMaskIntoConstraints = false
        //MARK: - settings petLabel
        petLabel.text = "PET"
        petLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        petLabel.textColor = .black
        petLabel.translatesAutoresizingMaskIntoConstraints = false
        //MARK: - settings switchIcon
        switchIcon.image = UIImage(systemName: "arrow.left.arrow.right")
        switchIcon.tintColor = .black
        switchIcon.translatesAutoresizingMaskIntoConstraints = false
        modeButton.addSubview(humanLabel)
        modeButton.addSubview(switchIcon)
        modeButton.addSubview(petLabel)
        view.addSubview(modeButton)
        //MARK: - Добавляем обработчик для modeButton
        modeButton.addTarget(self, action: #selector(switchLabels), for: .touchUpInside)
    }
    
    //MARK: - Create startSpeakButton
    func createStartButton() {
        startSpeakButton = UIButton(type: .system)
        startSpeakButton.translatesAutoresizingMaskIntoConstraints = false
        startSpeakButton.backgroundColor = UIColor.white
        startSpeakButton.layer.cornerRadius = 20
        startSpeakButton.layer.shadowColor = UIColor.black.cgColor
        startSpeakButton.layer.shadowOpacity = 0.2
        startSpeakButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startSpeakButton.layer.shadowRadius = 6
        //MARK: - settings micImage
        let micImage = UIImage(named: "mic")
        startSpeakButton.setImage(micImage, for: .normal)
        startSpeakButton.tintColor = UIColor.black
        startSpeakButton.setTitle("Start Speak", for: .normal)
        startSpeakButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        startSpeakButton.setTitleColor(.black, for: .normal)
        //MARK: - distance between icon and text
        let spacing: CGFloat = 8
        startSpeakButton.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -micImage!.size.width, bottom: -micImage!.size.height, right: 0)
        startSpeakButton.imageEdgeInsets = UIEdgeInsets(top: -startSpeakButton.titleLabel!.intrinsicContentSize.height - spacing, left: 0, bottom: 0, right: -startSpeakButton.titleLabel!.intrinsicContentSize.width)
        startSpeakButton.addTarget(self, action: #selector(micButtonTapped), for: .touchUpInside)
        view.addSubview(startSpeakButton)
        //MARK: - settings recordingImage
        recordingImageView.image = UIImage(systemName: "waveform")
        recordingImageView.backgroundColor = .white
        recordingImageView.tintColor = .red
        recordingImageView.contentMode = .scaleAspectFit
        recordingImageView.translatesAutoresizingMaskIntoConstraints = false
        recordingImageView.isHidden = true
        view.addSubview(recordingImageView)
    }
    
    //MARK: - Create segmentControl
    func createModeSegmentControl() {
        let catImage = UIImage(named: "catPNG")
        let dogImage = UIImage(named: "dogPNG")
        
        guard let cat = catImage?.rotate(radians: -.pi / 2)?.withRenderingMode(.alwaysOriginal),
              let dog = dogImage?.rotate(radians: -.pi / 2)?.withRenderingMode(.alwaysOriginal) else {
            print("error loading images")
            return
        }
        //MARK: - settings segmentControl
        modeSegmentControl = UISegmentedControl(items: [cat, dog])
        modeSegmentControl.backgroundColor = .white
        modeSegmentControl.selectedSegmentIndex = 0
        modeSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        modeSegmentControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        modeSegmentControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        modeSegmentControl.layer.cornerRadius = 20
        modeSegmentControl.layer.borderWidth = 1
        modeSegmentControl.layer.borderColor = UIColor.lightGray.cgColor
        modeSegmentControl.layer.masksToBounds = true
        modeSegmentControl.transform = CGAffineTransform(rotationAngle: .pi / 2)
        view.addSubview(modeSegmentControl)
        modeSegmentControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        
        segmentControl(modeSegmentControl)
    }
    
    //MARK: Create imageView
    func createImageView() {
        imagePet.backgroundColor = .clear
        imagePet.contentMode = .scaleAspectFit
        imagePet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imagePet)
    }
    
    //MARK: - Create Constraints
    func createConstraints() {
        //MARK: - Create constraints for humanLabel and petLabel
        humanLabelLeftConstraint = humanLabel.leadingAnchor.constraint(equalTo: modeButton.leadingAnchor, constant: -60)
        humanLabelRightConstraint = humanLabel.trailingAnchor.constraint(equalTo: modeButton.trailingAnchor, constant: 40)
        petLabelRightConstraint = petLabel.trailingAnchor.constraint(equalTo: modeButton.trailingAnchor, constant: 40)
        petLabelLeftConstraint = petLabel.leadingAnchor.constraint(equalTo: modeButton.leadingAnchor, constant: -10)
        //MARK: -  Activate the initial constraints (HUMAN on the left, PET on the right)
        humanLabelLeftConstraint?.isActive = true
        petLabelRightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            //MARK: - titleLabel constraint
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            //MARK: - modeButton constraint
            modeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            modeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modeButton.widthAnchor.constraint(equalToConstant: 120),
            modeButton.heightAnchor.constraint(equalToConstant: 40),
            //MARK: - humanLabel constraint
            humanLabel.centerYAnchor.constraint(equalTo: modeButton.centerYAnchor),
            //MARK: - switchIcon constraint
            switchIcon.centerXAnchor.constraint(equalTo: modeButton.centerXAnchor),
            switchIcon.centerYAnchor.constraint(equalTo: modeButton.centerYAnchor),
            //MARK: - petLabel constraint
            petLabel.centerYAnchor.constraint(equalTo: modeButton.centerYAnchor),
            //MARK: - startSpeakButton constraint
            startSpeakButton.topAnchor.constraint(equalTo: humanLabel.bottomAnchor, constant: 100),
            startSpeakButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startSpeakButton.widthAnchor.constraint(equalToConstant: 180),
            startSpeakButton.heightAnchor.constraint(equalToConstant: 180),
            //MARK: - recordingImage constraint
            recordingImageView.centerXAnchor.constraint(equalTo: startSpeakButton.centerXAnchor),
            recordingImageView.centerYAnchor.constraint(equalTo: startSpeakButton.centerYAnchor),
            recordingImageView.widthAnchor.constraint(equalTo: startSpeakButton.widthAnchor),
            recordingImageView.heightAnchor.constraint(equalTo: startSpeakButton.heightAnchor),
            //MARK: - modeSegmentControl constraint
            modeSegmentControl.leadingAnchor.constraint(equalTo: startSpeakButton.trailingAnchor, constant: 80),
            modeSegmentControl.centerYAnchor.constraint(equalTo: startSpeakButton.centerYAnchor),
            modeSegmentControl.widthAnchor.constraint(equalTo: startSpeakButton.widthAnchor),
            modeSegmentControl.heightAnchor.constraint(equalToConstant: 75),
            //MARK: imagePet constraint
            imagePet.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePet.topAnchor.constraint(equalTo: view.topAnchor, constant: 596), // Новый отступ сверху
            imagePet.widthAnchor.constraint(equalToConstant: 184),
            imagePet.heightAnchor.constraint(equalToConstant: 184)
        ])
    }
    
    //MARK: - selector micButton
    @objc func micButtonTapped() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.startRecording()
                        self.toggleRecordingUI()
                        self.isRecording = true
                    }
                }
            }
        case .denied:
            showMicAlert(title: "Enable Microphone Access", message: "Please allow access to your mircophone to use the app’s features")
        case .granted:
            if isRecording {
                stopRecording()
                isRecording = false
                resetRecordingUI()
            } else {
                startRecording()
                toggleRecordingUI()
                isRecording = true
            }
            if !isRecording {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.navigateToProcessingScreen()
                }
            }
        }
    }
    
    //MARK: - resetting the microphone button and returning it to the reverse position
    func resetRecordingUI() {
        startSpeakButton.setBackgroundImage(nil, for: .normal)
        startSpeakButton.backgroundColor = UIColor.white
        startSpeakButton.layer.cornerRadius = 20
        startSpeakButton.layer.shadowColor = UIColor.black.cgColor
        startSpeakButton.layer.shadowOpacity = 0.2
        startSpeakButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        startSpeakButton.layer.shadowRadius = 6
        
        let micImage = UIImage(named: "mic")
        startSpeakButton.setImage(micImage, for: .normal)
        startSpeakButton.tintColor = UIColor.black
        startSpeakButton.setTitle("Start Speak", for: .normal)
        startSpeakButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        startSpeakButton.setTitleColor(.black, for: .normal)
    }
    
    //MARK: selector segmentControl
    @objc func segmentControl(_ sender: UISegmentedControl) {
        let selectedImage = sender.selectedSegmentIndex == 0 ? UIImage(named: "catPNG") : UIImage(named: "dogPNG")
        imagePet.image = selectedImage
        selectedAnimalImage = selectedImage
    }
    
    //MARK: - selector translator and clecker
    @objc func translatorButtonTapped() {
        print("Translator button tapped!")
    }
    
    @objc func clickerTapped() {
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    //MARK: - selector switch label (pet -> human, human -> pet)
    @objc func switchLabels() {
        isHumanOnLeft.toggle()
        if isHumanOnLeft {
            humanLabelRightConstraint?.isActive = false
            petLabelLeftConstraint?.isActive = false
            humanLabelLeftConstraint?.isActive = true
            petLabelRightConstraint?.isActive = true
        } else {
            humanLabelLeftConstraint?.isActive = false
            petLabelRightConstraint?.isActive = false
            humanLabelRightConstraint?.isActive = true
            petLabelLeftConstraint?.isActive = true
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - switching the micButton icon depending on the state
    func toggleRecordingUI() {
        isRecording.toggle()
        if isRecording {
            startSpeakButton.setImage(nil, for: .normal)
            startSpeakButton.setTitle("", for: .normal)
            startSpeakButton.backgroundColor = UIColor.white
            startSpeakButton.setBackgroundImage(UIImage(systemName: "waveform"), for: .normal)
            startSpeakButton.tintColor = .systemBlue
        } else {
            let micImage = UIImage(systemName: "mic")
            startSpeakButton.setImage(micImage, for: .normal)
            startSpeakButton.setTitle("Start Speak", for: .normal)
            startSpeakButton.backgroundColor = UIColor.white
            startSpeakButton.setBackgroundImage(nil, for: .normal)
            startSpeakButton.tintColor = .black
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    //MARK: - Alert
    func showMicAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Allow Access", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Don’t Allow", style: .cancel)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    //MARK: - quared
    func startRecording() {
        print("Start Recording")
    }
    
    func stopRecording() {
        print("Stop Recording")
    }
    
    //MARK: - transfer of the animal to the next facility
    func navigateToProcessingScreen() {
        let processingVC = ProcessingViewController()
        processingVC.selectedAnimalImage = imagePet.image
        if modeSegmentControl.selectedSegmentIndex == 0 {
            processingVC.selectedAnimalType = "cat3D"
        } else {
            processingVC.selectedAnimalType = "dog3D"
        }
        navigationController?.pushViewController(processingVC, animated: true)
    }
}

//MARK: - update animal image
extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: rect.midX, y: rect.midY)
        context.rotate(by: CGFloat(radians))
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
