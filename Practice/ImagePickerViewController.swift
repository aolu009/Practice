//
//  ImagePickerViewController.swift
//  Practice
//
//  Created by Lu Ao on 10/29/17.
//  Copyright © 2017 Lu Ao. All rights reserved.
//

import UIKit
import AVFoundation


//@IBDesignable

class ImagePickerViewController: UIViewController,AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var imagePreview: PreviewImageView!
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup your camera here...
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.hd1280x720
        stillImageOutput = AVCapturePhotoOutput()
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
            if session!.canAddOutput(stillImageOutput!) {
                session!.addOutput(stillImageOutput!)
                // ...
                // Configure the Live Preview here...
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspect
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                videoPreviewLayer!.frame = previewView.layer.frame
                previewView.layer.addSublayer(videoPreviewLayer!)
                session!.startRunning()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.bounds
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func didTakePhoto(_ sender: Any) {
        print("press")
        let settings = AVCapturePhotoSettings(format:["AVVideoCodecKey": AVVideoCodecType.jpeg])
        stillImageOutput?.capturePhoto(with: settings, delegate: self)
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let dataImage = photo.fileDataRepresentation() {
            //self.captureImageView.image = UIImage(data: dataImage)
            self.imagePreview.image = UIImage(data: dataImage)
            self.imagePreview.expandToFull(to: self.view.frame)
            
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "ImagePickerViewController", bundle: nil)
        initController()
    }
    
    override init(nibName: String? , bundle: Bundle?) {
        super.init(nibName: "ImagePickerViewController", bundle: nil)
        initController()
    }
    
    func initController() {
        let nib = UINib(nibName: "ImagePickerViewController", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        
//        captureImageView.contentMode = UIViewContentMode.scaleAspectFill
//        captureImageView.clipsToBounds = true
    }
    
    
    /*
     func askPermission() {
     print("here")
     let cameraPermissionStatus =  AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
     
     switch cameraPermissionStatus {
     case .authorized:
     print("Already Authorized")
     case .denied:
     print("denied")
     
     let alert = UIAlertController(title: "Sorry :(" , message: "But  could you please grant permission for camera within device settings",  preferredStyle: .alert)
     let action = UIAlertAction(title: "Ok", style: .cancel,  handler: nil)
     alert.addAction(action)
     present(alert, animated: true, completion: nil)
     
     case .restricted:
     print("restricted")
     default:
     AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {
     [weak self]
     (granted :Bool) -> Void in
     
     if granted == true {
     // User granted
     print("User granted")
     DispatchQueue.main.async(){
     //Do smth that you need in main thread
     }
     }
     else {
     // User Rejected
     print("User Rejected")
     
     DispatchQueue.main.async(){
     let alert = UIAlertController(title: "WHY?" , message:  "Camera it is the main feature of our application", preferredStyle: .alert)
     let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
     alert.addAction(action)
     self?.present(alert, animated: true, completion: nil)
     }
     }
     });
     }
     }
     }
    */
}
