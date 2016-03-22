//
//  InterfaceFactory.swift
//  CustomTVMLViews
//
//  Created by Max Fellmuth on 15/03/16.
//  Copyright © 2016 tape.tv. All rights reserved.
//

import TVMLKit
import UIKit

/*
 The InterfaceFactory will return Views and ViewControllers for our custom view.
 
 After we added it as an `extendedInterfaceCreator` in our AppDelegate it will be called for every element in the current TVML Document
*/
class InterfaceFactory: TVInterfaceFactory {
  
  /*
    Since TVInterfaceFactory only accepts a single `extendedInterfaceCreator` we make our class a singleton to avoid confusion.
  */
  static var sharedExtendedInterfaceFactory = InterfaceFactory()
  
  /*
    We implement a custom `viewForElement` function to have a chance of returning a UIView for a TVViewElement.
  
    This method will be called for every element in the current TVML Document.
    If we want to provide a view for the element we return a UIView.
    Otherwise we return nil and the system will take care of it. You could also return nil if your element does not display a view to the user (like the background audio element for example)
  
    In our app we differenciate between the elements using a switch command. It does the job well and is easily extendable and understandable. However, depending on the complexity and amount of custom view in your project this could get messy and you may want to think about a different solution at some point.
  
    In this simple example we registered `rainbowText` with the element class TVTextElement because that's what it is.
  */
  override func viewForElement(element: TVViewElement, existingView: UIView?) -> UIView? {
    switch element {
    case let element as TVTextElement where element.elementName == "rainbowText":
      
      // MARK: rainbowText
      
      guard let attributedText = element.attributedText else { return nil }
      
      let rainbowString = NSMutableAttributedString(attributedString: attributedText)
      
      for position in 0..<rainbowString.length {
        rainbowString.addAttribute(
          NSForegroundColorAttributeName,
          value: UIColor(
            hue: CGFloat(position) / CGFloat(rainbowString.length),
            saturation: 1.0,
            brightness: 1.0,
            alpha: 1.0
          ),
          range: NSMakeRange(position, 1)
        )
      }
      
      let rainbowLabel = UILabel(frame: CGRect.zero)
      rainbowLabel.attributedText = rainbowString
      
      return rainbowLabel
      
    case let element as RainbowProgressElement:
      
      // MARK: rainbowProgress
      
      let width = element.explicitWidth ?? 200.0
      let height = element.explicitHeight ?? 10.0
      
      let rainbowProgressView = RainbowProgress(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
      
      if let margin = element.style?.margin {
        rainbowProgressView.layoutMargins = margin
      }
      
      rainbowProgressView.progress = element.progress ?? 0.0
      
      return rainbowProgressView
      
    default:
      return nil
    }
  }
}
