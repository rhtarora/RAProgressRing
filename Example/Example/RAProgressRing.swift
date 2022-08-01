//MIT License
//
//Copyright (c) 2022 Rohit Arora
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

//  RACircularProgressBar.swift
//
//  Created by Rohit Arora on 02/08/22..
//

import Foundation
import UIKit
@IBDesignable
class RAProgressRing: UIView {
    
    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    
    @IBInspectable var lineWidth: CGFloat = 4.0 {
       didSet {
           backgroundLayer.lineWidth = lineWidth
           progressLayer.lineWidth = lineWidth
       }
    }
    
    @IBInspectable var animationDuration: CGFloat = 1.0 {
       didSet {
           backgroundLayer.lineWidth = lineWidth
           progressLayer.lineWidth = lineWidth
       }
    }
    @IBInspectable var trackColor: UIColor = .black.withAlphaComponent(0.25) {
       didSet {
           backgroundLayer.strokeColor = trackColor.cgColor
       }
    }
    @IBInspectable var circleColor: UIColor = .white {
       didSet {
           progressLayer.strokeColor = circleColor.cgColor
       }
    }
    @IBInspectable var progress: CGFloat = 0 {
       didSet {
           progressLayer.strokeEnd = progress
       }
    }
    
    // MARK: Life Cycle
        public init() {
            super.init(frame: .zero)
            setup()
        }

        override public init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
    
    func setup() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.width/2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = trackColor.cgColor
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.frame = CGRect(x: frame.width/2, y: -frame.height/2, width: frame.width, height: frame.height)
        layer.addSublayer(backgroundLayer)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = circleColor.cgColor
        progressLayer.lineCap = CAShapeLayerLineCap.round
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.frame = CGRect(x: frame.width/2, y: -frame.height/2, width: frame.width, height: frame.height)
        progressLayer.strokeEnd = 0
        backgroundLayer.transform = CATransform3DMakeRotation(-(CGFloat.pi / 2), 0, 0, 1)
        progressLayer.transform = CATransform3DMakeRotation(-(CGFloat.pi / 2), 0, 0, 1)
        layer.addSublayer(progressLayer)
        
    }
    
    public func setProgress(_ value: Float, animated: Bool, completion: (() -> Void)? = nil) {
        layoutIfNeeded()
        let value = CGFloat(min(value, 1.0))
        let oldValue = progressLayer.presentation()?.strokeEnd ?? progress
        progress = value
        progressLayer.strokeEnd = progress
        CATransaction.begin()
        let path = #keyPath(CAShapeLayer.strokeEnd)
        let fill = CABasicAnimation(keyPath: path)
        fill.fromValue = oldValue
        fill.toValue = value
        fill.duration = animationDuration
        CATransaction.setCompletionBlock(completion)
        progressLayer.add(fill, forKey: "fill")
        CATransaction.commit()
    }
}
