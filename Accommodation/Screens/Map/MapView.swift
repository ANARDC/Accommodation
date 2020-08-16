//
//  MapView.swift
//  Accommodation
//
//  Created by Anar on 14.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import CoreLocation
import YandexMapKit

final class MapView: YMKMapView {
  var nativeLocationManager: CLLocationManager!
  
  var mapCameraMoved = false
  
  var mapViewCameraListener = MapViewCameraListener { point in
    Geocoder.start(for: point) { pointName in
      print(pointName)
    }
  }
  
  convenience init(superview: UIView, constraints: (MapView) -> ()) {
    self.init(frame: UIScreen.main.bounds)
    self.setup()
    superview.addSubview(self)
    constraints(self)
  }
}

private extension MapView {
  func setup() {
    self.makeView()
    self.makeMap()
    self.makeLocationManager()
  }
  
  func makeView() {
    self.layer.backgroundColor = UIColor.white.cgColor
  }
  
  func makeMap() {
    self.mapWindow.map.isRotateGesturesEnabled = false
    self.mapWindow.map.addCameraListener(with: self.mapViewCameraListener)
  }
  
  func makeLocationManager() {
    self.nativeLocationManager = CLLocationManager()
    self.nativeLocationManager.delegate = self
    self.nativeLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    self.nativeLocationManager.startUpdatingLocation()
  }
}

extension MapView: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first, !self.mapCameraMoved else { return }
    
    self.mapWindow.map.move(with: YMKCameraPosition(target: YMKPoint(latitude: location.coordinate.latitude,
                                                                     longitude: location.coordinate.longitude),
                                                    zoom: 15,
                                                    azimuth: 0,
                                                    tilt: 0),
                            animationType: YMKAnimation(type: .smooth, duration: 5),
                            cameraCallback: nil)
    
    self.mapCameraMoved.toggle()
  }
}
