//
//  MapCenterPointImageView.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class MapCenterPointImageView: UIImageView {
  convenience init(superview: UIView, constraints: (MapCenterPointImageView) -> ()) {
    self.init(image: UIImage(named: "MapCenterPointIcon"))
    superview.addSubview(self)
    constraints(self)
  }
}
