//
//  SetupFunctionalities.swift
//  ObjectRecognizer
//
//  Created by Staham Nguyen on 09/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

extension CameraVC {
    
    internal func addTapGestureToCameraView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        cameraView.addGestureRecognizer(tap)
    }
    
    internal func setupCameraOutputPreview() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            cameraOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(cameraOutput) {
                captureSession.addOutput(cameraOutput!)
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            previewLayer.videoGravity = .resizeAspect
            previewLayer.connection?.videoOrientation = .portrait
            
            cameraView.layer.addSublayer(previewLayer!)
            captureSession.startRunning()
        } catch {
            debugPrint(error)
        }
    }
    
    @objc internal func didTapCameraView() {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.__availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType, kCVPixelBufferWidthKey as String: 160, kCVPixelBufferHeightKey as String: 160]
        
        settings.previewPhotoFormat = previewFormat
        
        if flashState == .off {
            settings.flashMode = .off
        } else {
            settings.flashMode = .on
        }
        
        cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
}
