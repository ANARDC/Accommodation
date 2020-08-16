//
//  MapPointNameLabel.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class MapPointNameLabel: UILabel {
  convenience init(superview: UIView, constraints: (MapPointNameLabel) -> ()) {
    self.init()
    self.setup()
    superview.addSubview(self)
    constraints(self)
  }
  
  private func setup() {
    self.textColor     = .black
    self.font          = .systemFont(ofSize: 35, weight: .medium)
    self.numberOfLines = 0
  }
}
