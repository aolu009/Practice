//
//  HamburgerViewControllerExtension.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/20/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

extension HamburgerViewController{
    
    
    func performPinRightAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.leftMarginConstrain.constant = 0
            self.rightMarginConstrain.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func setupCameraView(){
        phototaker = ImagePickerViewController(nibName: "ImagePickerViewController", bundle: nil)
        phototaker?.view.frame = self.view.bounds
    }
    
    
    
    func performPanRightAction(_ panGestureRecognizer: UIPanGestureRecognizer){
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)
        
        if panGestureRecognizer.state == .began {
            self.originalLeftMargin = leftMarginConstrain.constant
            self.originalRighttMargin = rightMarginConstrain.constant
        } else if panGestureRecognizer.state == .changed {
            leftMarginConstrain.constant = self.originalLeftMargin + translation.x
            rightMarginConstrain.constant = self.originalRighttMargin - translation.x
        } else if panGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.5, animations: {
                if velocity.x > 0{
                    self.leftMarginConstrain.constant = self.view.frame.width - 100
                    self.rightMarginConstrain.constant =  -self.view.frame.width + 100
                }else if velocity.x < 0{
                    if self.originalLeftMargin == self.view.frame.width - 100{
                        self.leftMarginConstrain.constant = 0
                        self.rightMarginConstrain.constant = 0
                    }else{
                        self.setupCameraView()
                        self.menuViewController = self.phototaker//imagepicker
                        self.leftMarginConstrain.constant = -self.view.frame.width
                        self.rightMarginConstrain.constant = self.view.frame.width
                    }
                }else{
                    self.leftMarginConstrain.constant = 0
                    self.rightMarginConstrain.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    func performPanLeftAction(_ panGestureRecognizer: UIPanGestureRecognizer){
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)

        if panGestureRecognizer.state == .began {
            self.originalLeftMargin = leftMarginConstrain.constant
            self.originalRighttMargin = rightMarginConstrain.constant
        } else if panGestureRecognizer.state == .changed {
            if self.menuViewController === phototaker && velocity.x > 0{
                leftMarginConstrain.constant = self.originalLeftMargin + translation.x
                rightMarginConstrain.constant = self.originalRighttMargin - translation.x
            }
            if self.menuViewController === self.tempViewController && velocity.x < 0{
                leftMarginConstrain.constant = self.originalLeftMargin + translation.x
                rightMarginConstrain.constant = self.originalRighttMargin - translation.x
            }
        } else if panGestureRecognizer.state == .ended {
            UIView.animate(withDuration: 0.5, animations: {
                self.leftMarginConstrain.constant = 0
                self.rightMarginConstrain.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { (Bool) in
                if velocity.x > 0{
                    self.menuViewController = self.tempViewController
                }
            })

        }
    }
    
    
}
