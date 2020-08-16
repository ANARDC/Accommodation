//
//  MapViewCameraListener.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import YandexMapKit

class MapViewCameraListener: NSObject, YMKMapCameraListener {
  typealias Callback = (_ point: YMKPoint) -> ()
  
  var closure: Callback?
  
  convenience init(closure: @escaping Callback) {
    self.init()
    self.closure = closure
  }
  
  func onCameraPositionChanged(with map: YMKMap,
                               cameraPosition: YMKCameraPosition,
                               cameraUpdateSource: YMKCameraUpdateSource,
                               finished: Bool) {
    guard finished else { return }
    
    self.closure?(YMKPoint(latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude))
  }
}
