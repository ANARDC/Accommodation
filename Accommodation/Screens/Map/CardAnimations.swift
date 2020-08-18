//
//  CardAnimations.swift
//  Accommodation
//
//  Created by Anar on 17.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class CardAnimations {
  let view : UIView
  let card : CardViewController?
  
  var cardRunningAnimation             : UIViewPropertyAnimator?
  var animationProgressWhenInterrupted : CGFloat = 0
  
  init(view: UIView, card: CardViewController?) {
    self.view = view
    self.card = card
  }
  
  func cardAnimateTransitionIfNeeded(duration: TimeInterval) {
    if self.cardRunningAnimation == nil {
      let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
        self.card?.view.frame.origin.y = self.view.frame.height
      }
      
      frameAnimator.addCompletion { position in
        self.cardRunningAnimation = nil
        
        if position == .end {
          self.card?.view.removeFromSuperview()
          self.card?.removeFromParent()
        }
      }
      
      frameAnimator.startAnimation()
      
      self.cardRunningAnimation = frameAnimator
    }
  }
}
