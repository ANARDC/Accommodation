//
//  MapView.swift
//  Accommodation
//
//  Created by Anar on 14.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import YandexMapKit
import RxSwift

final class MapView: YMKMapView {
  var mapService: MapService?
  
  var mapViewCameraListener: MapViewCameraListener?
  
  var mapCenterPointNameSubject: PublishSubject<String>?
  
  convenience init(superview: UIView, mapCenterPointNameSubject: PublishSubject<String>, constraints: (MapView) -> ()) {
    self.init(frame: UIScreen.main.bounds)
    self.mapCenterPointNameSubject = mapCenterPointNameSubject
    self.setup()
    superview.addSubview(self)
    constraints(self)
  }
}

private extension MapView {
  func setup() {
    self.makeView()
    self.makeMapViewCameraListener()
    self.makeMapService()
    self.makeMap()
  }
  
  func makeView() {
    self.layer.backgroundColor = UIColor.white.cgColor
  }
  
  func makeMapViewCameraListener() {
    self.mapViewCameraListener = MapViewCameraListener { point in
      Geocoder.start(for: point) { pointName in
        self.mapCenterPointNameSubject?.onNext(pointName)
      }
    }
  }
  
  func makeMapService() {
    self.mapService = MapService(mapView: self)
  }
  
  func makeMap() {
    guard let mapViewCameraListener = self.mapViewCameraListener else { return }
    
    self.mapWindow.map.logo.setAlignmentWith(YMKLogoAlignment(horizontalAlignment: .right, verticalAlignment: .top))
    self.mapWindow.map.isRotateGesturesEnabled = false
    self.mapWindow.map.addCameraListener(with: mapViewCameraListener)
  }
}

extension MapView {
  func locateMapCamera() {
    self.mapService?.locateCamera()
  }
}
