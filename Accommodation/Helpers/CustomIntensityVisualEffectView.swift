//
//  CustomIntensityVisualEffectView.swift
//  Accommodation
//
//  Created by Anar on 17.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

class CustomIntensityVisualEffectView: UIVisualEffectView {
  private var animator: UIViewPropertyAnimator!
  
  /// Создание вида визуального эффекта с заданным эффектом и его интенсивностью
  ///
  /// - Parameters:
  ///   - effect: визуальный эффект, например: UIBlurEffect(style: .dark)
  ///   - intensity: пользовательская интенсивность
  ///                от 0.0 (без эффекта) до 1.0 (полный эффект)
  ///                с использованием линейной шкалы
  ///
  init(effect: UIVisualEffect, intensity: CGFloat) {
    super.init(effect: nil)
    self.animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = effect }
    self.animator.fractionComplete = intensity
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
