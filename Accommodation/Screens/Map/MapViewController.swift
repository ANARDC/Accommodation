//
//  MapViewController.swift
//  Accommodation
//
//  Created by Anar on 13.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class MapViewController: UIViewController {
  var mapView: MapView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.makeMapView()
  }
  
  func makeMapView() {
    self.mapView = MapView(superview: self.view) { mapView in
      mapView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
  }
}
