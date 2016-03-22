//
//  RainbowProgressElement.swift
//  CustomTVMLViews
//
//  Created by Max Fellmuth on 20/03/16.
//  Copyright © 2016 tape.tv. All rights reserved.
//

import TVMLKit

class RainbowProgressElement: TVViewElement {
  var progress: Float? {
    guard let progress = attributes?["progress"] else { return nil }
    return Float(progress)
  }
  
  var explicitWidth: CGFloat? {
    return style?.valueForStyleProperty("width") as? CGFloat
  }
  
  var explicitHeight: CGFloat? {
    return style?.valueForStyleProperty("height") as? CGFloat
  }
}
