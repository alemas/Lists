//
//  CheckboxView.swift
//  Lists
//
//  Created by Mateus Reckziegel on 01/05/21.
//

import UIKit

protocol CheckboxViewDelegate {
    func didChangeCheckState(isChecked: Bool)
}

class CheckboxView: UIView {
    
    private var delegate: CheckboxViewDelegate?
    public var radius: CGFloat = 15
    public var color: UIColor = UIColor.systemTeal {
        didSet {
            self.setNeedsDisplay()
        }
    }
    public var isChecked: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialSetup()
    }
    
    private func initialSetup() {
        self.backgroundColor = UIColor.clear
        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didTouchUpInside(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let origin = CGPoint(x: rect.midX - self.radius, y: rect.midY - self.radius)

        self.color.set()
        
        let outerCircle = UIBezierPath.init(ovalIn: CGRect(origin: origin, size: CGSize(width: self.radius * 2, height: self.radius * 2)))
        outerCircle.lineWidth = 1.5
        outerCircle.stroke()
        
        if self.isChecked {
            let innerMargin: CGFloat = 5
            let innerRadius: CGFloat = self.radius - innerMargin
            let innerCircle = UIBezierPath.init(ovalIn: CGRect(origin: CGPoint(x: origin.x + innerMargin, y: origin.y + innerMargin),
                                                size: CGSize(width: innerRadius * 2, height: innerRadius * 2)))
            innerCircle.fill()
        }
        
        
    }
    
    //MARK: Actions
    
    @IBAction func didTouchUpInside(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.isChecked = !self.isChecked
            guard let delegate = self.delegate else { return }
            delegate.didChangeCheckState(isChecked: self.isChecked)
        }
    }

}
