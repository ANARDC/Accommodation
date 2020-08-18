//
//  HandleArea.swift
//  Accommodation
//
//  Created by Anar on 17.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import SnapKit

class HandleArea: UIView {
  var line: UIView?
  
  convenience init(superview: UIView, constraints: (HandleArea) -> ()) {
    self.init()
    self.setup()
    superview.addSubview(self)
    constraints(self)
  }
  
  private func setup() {
    self.makeView()
    self.makeLine()
  }
  
  private func makeView() {
    self.layer.backgroundColor = UIColor.clear.cgColor
  }
  
  private func makeLine() {
    self.line = UIView(frame: .zero)
    self.line?.layer.backgroundColor = UIColor.gray.cgColor
    self.line?.layer.cornerRadius = 2
    
    guard let line = self.line else { return }
    
    self.addSubview(line)
    
    line.snp.makeConstraints { maker in
      maker.centerX.equalToSuperview()
      maker.top.equalTo(10)
      maker.width.equalTo(60)
      maker.height.equalTo(5)
    }
  }
}
