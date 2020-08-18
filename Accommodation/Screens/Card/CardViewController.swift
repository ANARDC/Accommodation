//
//  CardViewController.swift
//  Accommodation
//
//  Created by Anar on 17.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class CardViewController: UIViewController {
  var handleArea: HandleArea?
  
  var pageView: UIView? {
    didSet {
      oldValue?.removeFromSuperview()
    }
  }
  
  var visualEffectView: CustomIntensityVisualEffectView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.makeView()
    self.makeBlur()
    self.makeHandleArea()
    self.makePageView()
    self.show()
  }
}

private extension CardViewController {
  func makeView() {
    self.view.layer.backgroundColor = UIColor.clear.cgColor
    self.view.layer.cornerRadius    = 35
    self.view.layer.shadowColor     = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
    self.view.layer.shadowOpacity   = 1
    self.view.layer.shadowRadius    = 50
  }
  
  func makeBlur() {
    let visualEffectView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 0.5)
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    visualEffectView.alpha = 0
    visualEffectView.clipsToBounds = true
    visualEffectView.layer.cornerRadius = self.view.layer.cornerRadius
    
    self.view.addSubview(visualEffectView)
    
    visualEffectView.snp.makeConstraints { maker in
      maker.edges.equalToSuperview()
    }
    
    self.visualEffectView = visualEffectView
  }
  
  func makeHandleArea() {
    self.handleArea = HandleArea(superview: self.view) { view in
      view.snp.makeConstraints { maker in
        maker.top.left.right.equalToSuperview()
        maker.height.equalTo(50)
      }
    }
  }
  
  func makePageView() {
    self.pageView = MainPage(controller: self) { view in
      view.snp.makeConstraints { [unowned self] maker in
        guard let handleArea = self.handleArea else { return }
        
        maker.top.equalTo(handleArea.snp.bottom)
        maker.bottom.left.right.equalToSuperview()
      }
    }
  }
  
  func show() {
    [self.visualEffectView, self.handleArea, self.pageView].forEach { view in
      view?.alpha = 0
      UIView.animate(withDuration: 0.6, animations: {
        view?.alpha = 1
      })
    }
  }
}
