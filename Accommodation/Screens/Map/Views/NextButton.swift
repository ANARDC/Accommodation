//
//  NextButton.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class NextButton: UIButton {
  var label: UILabel?
  
  convenience init(superview: UIView, constraints: (NextButton) -> ()) {
    self.init()
    self.setup()
    superview.addSubview(self)
    constraints(self)
  }
}

private extension NextButton {
  func setup() {
    self.makeButton()
    self.makeLabel()
  }
  
  func makeButton() {
    self.layer.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.9, alpha: 1).cgColor
    self.layer.cornerRadius = 10
  }
  
  func makeLabel() {
    self.label = UILabel()
    self.label?.text = "Дальше"
    self.label?.textColor = .white
    self.label?.font = .systemFont(ofSize: 15, weight: .semibold)
    
    guard let label = self.label else { return }
    
    self.addSubview(label)
    
    label.snp.makeConstraints { maker in
      maker.center.equalToSuperview()
    }
  }
}
