//
//  Geocoder.swift
//  Accommodation
//
//  Created by Anar on 16.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import YandexMapKit

class Geocoder {
  static func start(for point: YMKPoint, closure: @escaping (String) -> ()) {
    guard let url = URL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=\(YANDEX_GEOCODER_KEY)&format=json&geocode=\(point.longitude),\(point.latitude)") else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let data = data,
        let yandexGeoResponse = try? JSONDecoder().decode(YandexGeoResponse.self, from: data)
        else { return }
      
      if let response = yandexGeoResponse.response, let pointName = response.GeoObjectCollection.featureMember.first {
        closure(pointName.debugDescription)
        
        Accommodation.location = MapPoint(latitude: point.latitude,
                                          longitude: point.longitude)
      } else {
        closure(#"¯\_(ツ)_/¯"#)
      }
    }.resume()
  }
}
