//
//  PreviewImageView.swift
//  Practice
//
//  Created by Lu Ao on 10/30/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit

@IBDesignable
class PreviewImageView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    private (set) var originalSize: CGRect?
    
    var image: UIImage?{
        get{
            return previewImage.image
        }
        set{
            previewImage.image = newValue
            
        }
    }
    
    
    
    @IBAction func didTapSave(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        self.shirnkToCorner()
    }
    @IBAction func didTapCancel(_ sender: Any) {
        shirnkToCorner()
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        
    }
    
    func shirnkToCorner(){
        UIView.animate(withDuration: 1) {
            self.frame = self.originalSize!
        }
        
    }
    //to size: CGRect
    func expandToFull(to size: CGRect){
        UIView.animate(withDuration: 1) {
            self.frame = size
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        let nib = UINib(nibName: "PreviewImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        self.originalSize = self.frame
        previewImage.contentMode = UIViewContentMode.scaleAspectFill
        previewImage.clipsToBounds = true
        addSubview(contentView)
    }
    
}
