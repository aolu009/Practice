//
//  HamburgerViewController.swift
//  TwitterReMake
//
//  Created by Lu Ao on 8/16/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var menuNCameraView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftMarginConstrain: NSLayoutConstraint!
    @IBOutlet weak var rightMarginConstrain: NSLayoutConstraint!
    
    
    
    var originalLeftMargin: CGFloat!
    var originalRighttMargin: CGFloat!
    var imagepicker: UIImagePickerController?
    
    
    var tempViewController: UIViewController?
    
    var menuViewController: UIViewController!{
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            if oldContentViewController != nil{
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            menuViewController.willMove(toParentViewController: self)
            self.menuNCameraView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)//CHeck here
        }
    }
    
    var contentViewController: UIViewController!{
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            if oldContentViewController != nil{
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            contentViewController.willMove(toParentViewController: self)
            self.contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            performPinRightAnimation()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            imagepicker = UIImagePickerController()
            imagepicker?.delegate = self
            imagepicker?.sourceType = UIImagePickerControllerSourceType.camera
            imagepicker?.showsCameraControls = true
            imagepicker?.allowsEditing = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        performPinRightAnimation()
        self.menuViewController = self.tempViewController
    }
    
    
    @IBAction func onPaningRight(_ panGestureRecognizer: UIPanGestureRecognizer) {
        performPanRightAction(panGestureRecognizer)
    }
    
    @IBAction func panLeft(_ panGestureRecognizer: UIPanGestureRecognizer) {
        performPanLeftAction(panGestureRecognizer)
    }
    

}
