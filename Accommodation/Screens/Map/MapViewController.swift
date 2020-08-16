//
//  MapViewController.swift
//  Accommodation
//
//  Created by Anar on 13.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit
import RxSwift
import RxCocoa

class MapViewController: UIViewController {
  var mapView                 : MapView?
  var mapCenterPointImageView : MapCenterPointImageView?
  var mapPointNameLabel       : MapPointNameLabel?
  var nextButton              : NextButton?
  var mapLocationButton       : MapLocationButton?
  
  var mapLocationButtonDriver: Driver<Void>? { self.mapLocationButton?.rx.tap.asDriver() }
  var mapCenterPointNameSubject = PublishSubject<String>()
  
  let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.makeMapView()
    self.makeMapCenterPointImageView()
    self.makeMapPointNameLabel()
    self.makeNextButton()
    self.makeMapLocationButton()
    
    self.makeMapLocationButtonDriverSubscriber()
    self.makeMapCenterPointNameSubscriber()
  }
}

// MARK: - UI Making
extension MapViewController {
  func makeMapView() {
    self.mapView = MapView(superview: self.view,
                           mapCenterPointNameSubject: self.mapCenterPointNameSubject) { mapView in
      mapView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
  }
  
  func makeMapCenterPointImageView() {
    guard let mapView = self.mapView else { return }
    
    self.mapCenterPointImageView = MapCenterPointImageView(superview: mapView) { imageView in
      imageView.snp.makeConstraints { $0.center.equalToSuperview() }
    }
  }
  
  func makeMapPointNameLabel() {
    guard let mapView = self.mapView, let mapCenterPointImageView = self.mapCenterPointImageView else { return }
    
    self.mapPointNameLabel = MapPointNameLabel(superview: mapView) { label in
      label.snp.makeConstraints { maker in
        maker.top.equalToSuperview().offset(40)
        maker.left.equalToSuperview().offset(30)
        maker.right.equalToSuperview().offset(-30)
        maker.bottom.lessThanOrEqualTo(mapCenterPointImageView.snp.top).offset(-30)
      }
    }
  }
  
  func makeNextButton() {
    guard let mapView = self.mapView else { return }
    
    self.nextButton = NextButton(superview: mapView) { button in
      button.snp.makeConstraints { maker in
        maker.bottom.equalToSuperview().offset(-25)
        maker.left.equalToSuperview().offset(10)
        maker.right.equalToSuperview().offset(-10)
        maker.height.equalTo(50)
      }
    }
  }
  
  func makeMapLocationButton() {
    guard let mapView = self.mapView, let nextButton = self.nextButton else { return }
    
    self.mapLocationButton = MapLocationButton(superview: mapView) { button in
      button.snp.makeConstraints { maker in
        maker.left.equalTo(mapView).offset(20)
        maker.bottom.equalTo(nextButton.snp.top).offset(-20)
        maker.height.width.equalTo(30)
      }
    }
  }
}

// MARK: - Reactive
extension MapViewController {
  func makeMapLocationButtonDriverSubscriber() {
    self.mapLocationButtonDriver?
      .drive(onNext: { self.mapView?.locateMapCamera() })
      .disposed(by: self.bag)
  }
  
  func makeMapCenterPointNameSubscriber() {
    self.mapCenterPointNameSubject
      .subscribe(onNext: { pointName in
        DispatchQueue.main.async {
          self.mapPointNameLabel?.text = pointName
        }
      })
      .disposed(by: self.bag)
  }
}
