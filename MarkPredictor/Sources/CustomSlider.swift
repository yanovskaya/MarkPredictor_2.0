//
//  CustomSlider.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 30.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import fluid_slider
import Foundation

final class CustomSlider: Slider {

    // MARK: - Public Methods
    
    func initialConfigure() {
        shadowOffset = CGSize(width: 0, height: 3)
        shadowColor = UIColor(white: 0, alpha: 0.1)
        shadowBlur = 5
        valueViewColor = .white
        backgroundColor = .clear
    }
    
    func observeTracking(label: UILabel) {
        didBeginTracking = { [weak self] _ in
            self!.setLabelHidden(true, label: label, animated: true)
        }
        didEndTracking = { [weak self] _ in
            self!.setLabelHidden(false, label: label, animated: true)
        }
    }
    
    // MARK: - Private Method
    
    private func setLabelHidden(_ hidden: Bool, label: UILabel, animated: Bool) {
        let animations = {
            label.alpha = hidden ? 0 : 1
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
    }
}
