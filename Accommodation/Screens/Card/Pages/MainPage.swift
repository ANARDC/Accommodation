//
//  MainPage.swift
//  Accommodation
//
//  Created by Anar on 17.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class MainPage: UIView {
  var controller: CardViewController?
  
  var pageLabel   : UILabel?
  var sexLabel    : UILabel?
  var sexValue    : UIView?
  var ageLabel    : UILabel?
  var ageValue    : UIView?
  var weightLabel : UILabel?
  var weightValue : UIView?
  var hobbyLabel  : UILabel?
  var hobbyValue  : UIView?
  var nextButton  : NextButton?
  
  convenience init(controller: CardViewController, constraints: (MainPage) -> ()) {
    self.init()
    self.setup()
    self.controller = controller
    controller.view.addSubview(self)
    constraints(self)
  }
}

private extension MainPage {
  func setup() {
    self.makePageLabel()
    self.makeSexLabel()
    self.makeSexValue()
    self.makeAgeLabel()
    self.makeAgeValue()
    self.makeWeightLabel()
    self.makeWeightValue()
    self.makeHobbyLabel()
    self.makeHobbyValue()
    self.makeNextButton()
  }
  
  func makePageLabel() {
    self.pageLabel                = UILabel()
    self.pageLabel?.numberOfLines = 1
    self.pageLabel?.text          = "Кто вам нужен?"
    self.pageLabel?.font          = .systemFont(ofSize: 30, weight: .semibold)
    
    guard let pageLabel = self.pageLabel else { return }
    
    self.addSubview(pageLabel)
    
    pageLabel.snp.makeConstraints { maker in
      maker.top.centerX.equalToSuperview()
    }
  }
  
  func makeSexLabel() {
    self.sexLabel = UILabel()
    self.sexLabel?.numberOfLines = 1
    self.sexLabel?.text          = "Пол:"
    self.sexLabel?.font          = .systemFont(ofSize: 20, weight: .medium)
    
    guard let sexLabel = self.sexLabel else { return }
    
    self.addSubview(sexLabel)
    
    sexLabel.snp.makeConstraints { maker in
      guard let pageLabel = self.pageLabel else { return }
      
      maker.top.equalTo(pageLabel.snp.bottom).offset(60)
      maker.left.equalTo(30)
    }
  }
  
  func makeSexValue() {
    if let sex = Accommodation.sex {
      let label = UILabel()
      label.text          = sex.rawValue.capitalized
      label.numberOfLines = 1
      label.font          = .systemFont(ofSize: 20, weight: .medium)
      self.sexValue = label
    } else {
      let button = UIButton()
      button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
      button.addTarget(self, action: #selector(self.addSexValue), for: .touchUpInside)
      button.imageView?.contentMode = .scaleAspectFit
      button.contentVerticalAlignment = .fill
      button.contentHorizontalAlignment = .fill
      button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      self.sexValue = button
    }
    
    guard let sexValue = self.sexValue else { return }
    
    self.addSubview(sexValue)
    
    sexValue.snp.makeConstraints { maker in
      guard let sexLabel = self.sexLabel else { return }
      
      maker.centerY.equalTo(sexLabel)
      maker.right.equalTo(-30)
      
      guard Accommodation.sex == nil else { return }
      
      maker.height.width.equalTo(30)
    }
  }
  
  func makeAgeLabel() {
    self.ageLabel = UILabel()
    self.ageLabel?.numberOfLines = 1
    self.ageLabel?.text          = "Возраст:"
    self.ageLabel?.font          = .systemFont(ofSize: 20, weight: .medium)
    
    guard let ageLabel = self.ageLabel else { return }
    
    self.addSubview(ageLabel)
    
    ageLabel.snp.makeConstraints { maker in
      guard let sexLabel = self.sexLabel else { return }
      
      maker.top.equalTo(sexLabel.snp.bottom).offset(20)
      maker.left.equalTo(30)
    }
  }
  
  func makeAgeValue() {
    if let age = Accommodation.age {
      let label = UILabel()
      label.text          = age.rawValue.capitalized
      label.numberOfLines = 1
      label.font          = .systemFont(ofSize: 20, weight: .medium)
      self.ageValue = label
    } else {
      let button = UIButton()
      button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.contentVerticalAlignment = .fill
      button.contentHorizontalAlignment = .fill
      button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      self.ageValue = button
    }
    
    guard let ageValue = self.ageValue else { return }
    
    self.addSubview(ageValue)
    
    ageValue.snp.makeConstraints { maker in
      guard let ageLabel = self.ageLabel else { return }
      
      maker.centerY.equalTo(ageLabel)
      maker.right.equalTo(-30)
      
      guard Accommodation.age == nil else { return }
      
      maker.height.width.equalTo(30)
    }
  }
  
  func makeWeightLabel() {
    self.weightLabel = UILabel()
    self.weightLabel?.numberOfLines = 1
    self.weightLabel?.text          = "Вес:"
    self.weightLabel?.font          = .systemFont(ofSize: 20, weight: .medium)
    
    guard let weightLabel = self.weightLabel else { return }
    
    self.addSubview(weightLabel)
    
    weightLabel.snp.makeConstraints { maker in
      guard let ageLabel = self.ageLabel else { return }
      
      maker.top.equalTo(ageLabel.snp.bottom).offset(20)
      maker.left.equalTo(30)
    }
  }
  
  func makeWeightValue() {
    if let weight = Accommodation.weight {
      let label = UILabel()
      label.text          = weight.rawValue.capitalized
      label.numberOfLines = 1
      label.font          = .systemFont(ofSize: 20, weight: .medium)
      self.weightValue = label
    } else {
      let button = UIButton()
      button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.contentVerticalAlignment = .fill
      button.contentHorizontalAlignment = .fill
      button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      self.weightValue = button
    }
    
    guard let weightValue = self.weightValue else { return }
    
    self.addSubview(weightValue)
    
    weightValue.snp.makeConstraints { maker in
      guard let weightLabel = self.weightLabel else { return }
      
      maker.centerY.equalTo(weightLabel)
      maker.right.equalTo(-30)
      
      guard Accommodation.weight == nil else { return }
      
      maker.height.width.equalTo(30)
    }
  }
  
  func makeHobbyLabel() {
    self.hobbyLabel = UILabel()
    self.hobbyLabel?.numberOfLines = 1
    self.hobbyLabel?.text          = "Интересы:"
    self.hobbyLabel?.font          = .systemFont(ofSize: 20, weight: .medium)
    
    guard let hobbyLabel = self.hobbyLabel else { return }
    
    self.addSubview(hobbyLabel)
    
    hobbyLabel.snp.makeConstraints { maker in
      guard let weightLabel = self.weightLabel else { return }
      
      maker.top.equalTo(weightLabel.snp.bottom).offset(20)
      maker.left.equalTo(30)
    }
  }
  
  func makeHobbyValue() {
    if let hobby = Accommodation.hobby {
      let label = UILabel()
      label.text          = hobby.rawValue.capitalized
      label.numberOfLines = 1
      label.font          = .systemFont(ofSize: 20, weight: .medium)
      self.hobbyValue = label
    } else {
      let button = UIButton()
      button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
      button.imageView?.contentMode = .scaleAspectFit
      button.contentVerticalAlignment = .fill
      button.contentHorizontalAlignment = .fill
      button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
      self.hobbyValue = button
    }
    
    guard let hobbyValue = self.hobbyValue else { return }
    
    self.addSubview(hobbyValue)
    
    hobbyValue.snp.makeConstraints { maker in
      guard let hobbyLabel = self.hobbyLabel else { return }
      
      maker.centerY.equalTo(hobbyLabel)
      maker.right.equalTo(-30)
      
      guard Accommodation.hobby == nil else { return }
      
      maker.height.width.equalTo(30)
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
  }
}

@objc extension MainPage {
  func addSexValue() {
    guard let controller = self.controller else { return }
    
    self.controller?.pageView = SexPage(controller: controller) { page in
      page.snp.makeConstraints { maker in
        guard let handleArea = controller.handleArea else { return }
        
        maker.top.equalTo(handleArea.snp.bottom)
        maker.bottom.left.right.equalToSuperview()
      }
    }
  }
}
