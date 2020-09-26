//
//  MapService.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import CoreLocation
import YandexMapKit

class MapService: NSObject {
  var mapView: MapView?
  var locationManager = CLLocationManager()
  
  var mapCameraMoved = false
  
  init(mapView: MapView) {
    super.init()
    self.mapView = mapView
    self.makeLocationManager()
  }
  
  private func makeLocationManager() {
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
}

extension MapService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard !self.mapCameraMoved else { return }
    
    self.locateCamera()
    
    self.mapCameraMoved.toggle()
  }
  
  func locateCamera() {
    guard let location = self.locationManager.location else { return }
    
    self.mapView?.mapWindow.map.move(with: YMKCameraPosition(target: YMKPoint(latitude: location.coordinate.latitude,
                                                                              longitude: location.coordinate.longitude),
                                                             zoom: 15,
                                                             azimuth: 0,
                                                             tilt: 0),
                                     animationType: YMKAnimation(type: .smooth, duration: 2),
                                     cameraCallback: nil)
  }
}
