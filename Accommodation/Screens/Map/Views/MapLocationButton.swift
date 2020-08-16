//
//  MapLocationButton.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class MapLocationButton: UIButton {
  convenience init(superview: UIView, constraints: (MapLocationButton) -> ()) {
    self.init()
    self.setImage(UIImage(named: "MapLocationIcon"), for: .normal)
    superview.addSubview(self)
    constraints(self)
  }
}
