//
//  SpeechBoubbleView.swift
//  TranslatorApp
//
//  Created by user on 28.02.2025.
//
import UIKit

class SpeechBubbleView: UIView {
    private let label = UILabel()
    private let bubbleLayer = CAShapeLayer()
    
    var text: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.label.text = text
        setupBubble()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - customizing the appearance and layers of SpeechBubbleView
    private func setupBubble() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.addSublayer(bubbleLayer)
    }
    
    //MARK: - create label for speechBouble
    private func setupLabel() {
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.backgroundColor = .clear
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //MARK: - label inside a SpeechBouble constraint
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - displaying a frame with text and a tail
    override func layoutSubviews() {
        super.layoutSubviews()
        print("Bounds: \(bounds)")
        updateBubblePath()
    }
    
    //MARK: - updating speechBoubble and adding a tail
    private func updateBubblePath() {
        let cornerRadius: CGFloat = 16
        let tailWidth: CGFloat = 20
        let tailHeight: CGFloat = 100
        //MARK: - frame dimensions excluding tail
        let bubbleRect = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )
        //MARK: - creation and management of vector paths
        let path = UIBezierPath()
        //MARK: - starting point upper left corner
        path.move(to: CGPoint(x: bubbleRect.minX + cornerRadius, y: bubbleRect.minY))
        //MARK: - top line and top right corner
        path.addLine(to: CGPoint(x: bubbleRect.maxX - cornerRadius, y: bubbleRect.minY))
        path.addArc(
            withCenter: CGPoint(x: bubbleRect.maxX - cornerRadius, y: bubbleRect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: 3 * .pi / 2,
            endAngle: 0,
            clockwise: true
        )
        //MARK: - right line to the point where the "tail" begins
        path.addLine(to: CGPoint(x: bubbleRect.maxX, y: bubbleRect.maxY - cornerRadius - tailWidth / 2))
        //MARK: - draw a “tail” a triangle starting in the lower right corner
        let tailStartY = bubbleRect.maxY - cornerRadius - tailWidth / 2
        let tailEndX = bubbleRect.midX // Указываем на центр животного по X
        let tailEndY = bubbleRect.maxY + tailHeight // Указываем на голову животного по Y
        path.addLine(to: CGPoint(x: bubbleRect.maxX, y: tailStartY + tailWidth))
        path.addLine(to: CGPoint(x: tailEndX, y: tailEndY))
        path.addLine(to: CGPoint(x: bubbleRect.maxX - cornerRadius, y: tailStartY + tailWidth / 2))
        //MARK: - bottom right corner
        path.addArc(
            withCenter: CGPoint(x: bubbleRect.maxX - cornerRadius, y: bubbleRect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: 0,
            endAngle: .pi / 2,
            clockwise: true
        )
        //MARK: - bottom line and lower left corner
        path.addLine(to: CGPoint(x: bubbleRect.minX + cornerRadius, y: bubbleRect.maxY))
        path.addArc(
            withCenter: CGPoint(x: bubbleRect.minX + cornerRadius, y: bubbleRect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .pi / 2,
            endAngle: .pi,
            clockwise: true
        )
        //MARK: - left line and upper left corner
        path.addLine(to: CGPoint(x: bubbleRect.minX, y: bubbleRect.minY + cornerRadius))
        path.addArc(
            withCenter: CGPoint(x: bubbleRect.minX + cornerRadius, y: bubbleRect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .pi,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )
        path.close()
        bubbleLayer.path = path.cgPath
        bubbleLayer.fillColor = UIColor(red: 0.85, green: 0.9, blue: 1.0, alpha: 1.0).cgColor
        bubbleLayer.strokeColor = nil
        bubbleLayer.lineWidth = 0.0
    }
}
