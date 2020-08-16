//
//  MapViewController.swift
//  Accommodation
//
//  Created by Anar on 13.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class MapViewController: UIViewController {
  var mapView              : MapView?
  var centerPointImageView : UIImageView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.makeMapView()
    self.makeCenterPointImageView()
  }
  
  func makeMapView() {
    self.mapView = MapView(superview: self.view) { mapView in
      mapView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
  }
  
  func makeCenterPointImageView() {
    guard let mapView = self.mapView else { return }
    
    self.centerPointImageView = MapCenterPointImageView(superview: mapView) { imageView in
      imageView.snp.makeConstraints { $0.center.equalToSuperview() }
    }
  }
}
