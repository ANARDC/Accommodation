//
//  YandexGeoResponse.swift
//  Accommodation
//
//  Created by Anar on 15.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import Foundation

struct YandexGeoResponse: Decodable {
  var response   : Response?
  var error      : String?
  var message    : String?
  var statusCode : Int?
}

struct Response: Decodable {
  let GeoObjectCollection: GeoObjectCollection
}

struct GeoObjectCollection: Decodable {
  let featureMember    : Array<FeatureMember>
  let metaDataProperty : MetaDataProperty
}

struct FeatureMember: Decodable {
  let GeoObject: GeoObject
}

extension FeatureMember: CustomDebugStringConvertible {
  var debugDescription: String {
    self.GeoObject.metaDataProperty.GeocoderMetaData.text
  }
}

struct GeoObject: Decodable {
  let Point            : Point
  let boundedBy        : BoundedBy
  let description      : String?
  let metaDataProperty : GeoObjectMetaDataProperty
  let name             : String
}

struct Point: Decodable {
  let pos: String
}

struct BoundedBy: Decodable {
  let Envelope: Envelope
}

struct Envelope: Decodable {
  let lowerCorner : String
  let upperCorner : String
}

struct GeoObjectMetaDataProperty: Decodable {
  let GeocoderMetaData: GeocoderMetaData
}

struct GeocoderMetaData: Decodable {
  let Address        : Address
  let AddressDetails : AddressDetails
  let kind           : String
  let precision      : String
  let text           : String
}

struct Address: Decodable {
  let Components   : Array<Component>
  let country_code : String
  let formatted    : String
}

struct AddressDetails: Decodable {
  let Country: Country
}

struct Country: Decodable {
  let AddressLine     : String
  let CountryName     : String
  let CountryNameCode : String
}

struct Component: Decodable {
  let kind : String
  let name : String
}

struct MetaDataProperty: Decodable {
  let GeocoderResponseMetaData: GeocoderResponseMetaData
}

struct GeocoderResponseMetaData: Decodable {
  let Point   : Point
  let found   : String
  let request : String
  let results : String
}
