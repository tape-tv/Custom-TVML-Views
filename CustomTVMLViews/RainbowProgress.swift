//
//  RainbowProgress.swift
//  CustomTVMLViews
//
//  Created by Max Fellmuth on 18/03/16.
//  Copyright © 2016 tape.tv. All rights reserved.
//

import UIKit

class RainbowProgress: UIView {
  
  // The BarView is progress part of the progress bar
  class BarView: UIView {
    
    // A rainbow layer that we add to the view
    private let rainbowLayer: CAGradientLayer = {
      let rainbowLayer = CAGradientLayer()
      
      // we want a horizontal gradient instead of a vertical one
      rainbowLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
      rainbowLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
      
      // this array will contain all the colors of the rainbow
      var rainbowColors = [CGColor]()
      
      // we iterate through all hues in increments of 10
      for var hue = CGFloat(0); hue <= 360; hue += 10 {
        rainbowColors.append(
          UIColor(
            hue: hue / 360,
            saturation: 1.0,
            brightness: 1.0,
            alpha: 1.0
            ).CGColor
        )
      }
      
      rainbowLayer.colors = rainbowColors
      
      return rainbowLayer
    }()
    
    // the width constraint's constant will be changed every time the progress of the size of the bar changes.
    private var widthConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      layer.addSublayer(rainbowLayer)
      
      translatesAutoresizingMaskIntoConstraints = false
      
      widthConstraint = NSLayoutConstraint(
        item: self,
        attribute: .Width,
        relatedBy: .Equal,
        toItem: nil,
        attribute: .NotAnAttribute,
        multiplier: 1,
        constant: 0
      )
      addConstraint(widthConstraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError()
    }
    
    override func layoutSubviews() {
      rainbowLayer.frame = bounds
    }
  }
  
  private let progressBar = BarView()
  
  private var progressBarWidth: CGFloat {
    return bounds.width * CGFloat(progress)
  }
  
  var progress: Float = 0.0 {
    didSet {
      assert(0...1 ~= progress, "Progress must be between 0.0 and 1.0")
      progressBar.widthConstraint.constant = progressBarWidth
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(white: 1, alpha: 0.5)
    clipsToBounds = true
    
    addSubview(progressBar)
    
    let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "|-0-[progressBar]",
      options: [],
      metrics: nil,
      views: [
        "progressBar": progressBar
      ]
    )
    
    let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
      "V:|-0-[progressBar]-0-|",
      options: [],
      metrics: nil,
      views: [
        "progressBar": progressBar
      ]
    )
    
    addConstraints(horizontalConstraints)
    addConstraints(verticalConstraints)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    layer.cornerRadius = bounds.height / 2
    progressBar.widthConstraint.constant = progressBarWidth
  }
}