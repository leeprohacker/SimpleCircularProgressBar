//
//  CircularProgressBar.swift
//  SimpleCircularProgressBar
//
//  Created by Leeprohacker on 3/6/19.
//  Copyright © 2019 Leeprohacker. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {

    @IBOutlet var contentView: UIView!

    var startAngleBg = CGFloat(Float(0).degreeToRadians)
    var endAngleBg = CGFloat(Float(360).degreeToRadians)

    var lineWidthOfProcess = CGFloat(12)

    private var backgroundProgressCA = CAShapeLayer()
    private var foregroundProcessCA = CAShapeLayer()


    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }

    private func commitInit() {
        Bundle.main.loadNibNamed("CircularProgressBar", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.fullSuperView()
        self.layoutIfNeeded()
        drawBackgroundProcess()
        updateProcess(processPercent: 50)
    }

    private func getRadius() -> CGFloat {
        return (contentView.frame.width - lineWidthOfProcess) / 2
    }

    private func drawBackgroundProcess() {
        backgroundProgressCA.removeFromSuperlayer()
        let bezier = UIBezierPath.init(arcCenter: contentView.center, radius: getRadius(), startAngle: startAngleBg, endAngle: endAngleBg, clockwise: true)
        backgroundProgressCA.path = bezier.cgPath
        backgroundProgressCA.fillColor = UIColor.clear.cgColor
        backgroundProgressCA.strokeColor = UIColor.gray.cgColor
        backgroundProgressCA.lineWidth = lineWidthOfProcess
        backgroundProgressCA.lineCap = .round
        self.contentView.layer.addSublayer(backgroundProgressCA)
    }


    private func drawForegroundProcess(startAngle: CGFloat, endAngle: CGFloat) {
        foregroundProcessCA.removeFromSuperlayer()
        let bezier = UIBezierPath.init(arcCenter: contentView.center, radius: getRadius(), startAngle: startAngle, endAngle: endAngle, clockwise: true)

        foregroundProcessCA.path = bezier.cgPath
        foregroundProcessCA.fillColor = UIColor.clear.cgColor
        foregroundProcessCA.strokeColor = UIColor.red.cgColor
        foregroundProcessCA.lineWidth = lineWidthOfProcess
        foregroundProcessCA.lineCap = .round

        self.contentView.layer.addSublayer(foregroundProcessCA)
    }


    // range [0/100]
    func updateProcess(processPercent: Float) {
        var process = processPercent
        if process > 100{
            process = 100
        }
        
        if  process < 0 {
            process = 0
        }
         
        let startAngle = Float(90)
        let endAngle = startAngle + process * 3.6
        
        drawForegroundProcess(startAngle: CGFloat(startAngle.degreeToRadians), endAngle: CGFloat(endAngle.degreeToRadians))

        }

        override func layoutSubviews() {
            super.layoutSubviews()
            print("layoutSubviews")
        }
    }


    extension UIView {
        public func fullSuperView() {
            guard let parentView = self.superview else {
                return
            }
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0).isActive = true
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0).isActive = true
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0).isActive = true
        }
    }


    extension FloatingPoint {

        var degreeToRadians: Self { return self * .pi / 180 }

    }

