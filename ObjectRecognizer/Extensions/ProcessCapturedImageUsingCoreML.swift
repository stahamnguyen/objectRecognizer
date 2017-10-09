//
//  ProcessCapturedImageUsingCoreML.swift
//  ObjectRecognizer
//
//  Created by Staham Nguyen on 09/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

extension CameraVC: AVCapturePhotoCaptureDelegate {
    
    internal func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            do {
                let model = try VNCoreMLModel(for: SqueezeNet().model)
                let request = VNCoreMLRequest(model: model, completionHandler: resultsMethod)
                let handler = VNImageRequestHandler(data: photoData!)
                try handler.perform([request])
            } catch {
                
            }
            
            let image = UIImage(data: photoData!)
            self.capturedImageView.image = image
        }
    }
    
    internal func resultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        for classification in results {
            if classification.confidence < 0.5 {
                self.objectNameLabel.text = "Not sure what this is. Please try again!"
                self.confidenceLabel.text = ""
            } else {
                self.objectNameLabel.text = classification.identifier
                self.confidenceLabel.text = "CONFIDENCE: \(Int(classification.confidence * 100))%"
                break
            }
        }
    }
    
}
