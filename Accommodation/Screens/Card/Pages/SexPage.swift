//
//  SexPage.swift
//  Accommodation
//
//  Created by Anar on 17.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit
import RxSwift
import RxCocoa

class SexPage: UIView {
  var controller: CardViewController?
  
  var returnButton : UIButton?
  var pickerView   : UIPickerView?
  var nextButton   : NextButton?
  
  var previousValue = Accommodation.sex
  
  let bag = DisposeBag()
  
  convenience init(controller: CardViewController, constraints: (SexPage) -> ()) {
    self.init()
    self.setup()
    self.controller = controller
    controller.view.addSubview(self)
    constraints(self)
  }
}

private extension SexPage {
  func setup() {
    self.makeReturnButton()
    self.makePickerView()
    self.makeNextButton()
    
    self.bindPickerViewSubscriber()
  }
  
  func makeReturnButton() {
    self.returnButton = UIButton()
    self.returnButton?.setImage(UIImage(systemName: "arrowtriangle.left.circle.fill"), for: .normal)
    self.returnButton?.addTarget(self, action: #selector(self.returnToMainPage), for: .touchUpInside)
    self.returnButton?.imageView?.contentMode = .scaleAspectFit
    self.returnButton?.contentVerticalAlignment = .fill
    self.returnButton?.contentHorizontalAlignment = .fill
    self.returnButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    guard let returnButton = self.returnButton else { return }
    
    self.addSubview(returnButton)
    
    returnButton.snp.makeConstraints { maker in
      maker.left.equalTo(15)
      maker.top.equalToSuperview()
      maker.height.width.equalTo(70)
    }
  }
  
  func makePickerView() {
    self.pickerView = UIPickerView()
    
    self.pickerView?.delegate = self
    self.pickerView?.dataSource = self
    
    guard let pickerView = self.pickerView, let returnButton = self.returnButton else { return }
    
    self.addSubview(pickerView)
    
    pickerView.snp.makeConstraints { maker in
      maker.top.equalTo(returnButton.snp.bottom).offset(50)
      maker.left.equalTo(50)
      maker.right.equalTo(-50)
      maker.height.equalTo(100)
    }
  }
  
  func makeNextButton() {
    self.nextButton = NextButton(superview: self) { button in
      button.snp.makeConstraints { maker in
        maker.bottom.equalTo(-25)
        maker.left.equalTo(10)
        maker.right.equalTo(-10)
        maker.height.equalTo(50)
      }
    }
    
    self.nextButton?.addTarget(self, action: #selector(self.goToMainPage), for: .touchUpInside)
  }
}

extension SexPage {
  func bindPickerViewSubscriber() {
    self.pickerView?.rx.itemSelected
      .startWith((0, 0))
      .subscribe(onNext: { item in
        Accommodation.sex = item.row == 0 ? .male : .female
      })
      .disposed(by: self.bag)
  }
}

@objc extension SexPage {
  func returnToMainPage() {
    Accommodation.sex = self.previousValue
    self.route()
  }
  
  func goToMainPage() {
    self.route()
  }
  
  func route() {
    guard let controller = self.controller else { return }
    
    self.controller?.pageView = MainPage(controller: controller) { view in
      view.snp.makeConstraints { maker in
        guard let handleArea = controller.handleArea else { return }
        
        maker.top.equalTo(handleArea.snp.bottom)
        maker.bottom.left.right.equalToSuperview()
      }
    }
  }
}

extension SexPage: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    Sex.allCases.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    Sex.allCases[row].rawValue.capitalized
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    35
  }
}
