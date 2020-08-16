//
//  CenterPointImageView.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class CenterPointImageView: UIImageView {
  convenience init(superview: UIView, constraints: (CenterPointImageView) -> ()) {
    self.init(image: UIImage(named: "CenterPointIcon"))
    superview.addSubview(self)
    constraints(self)
  }
}
