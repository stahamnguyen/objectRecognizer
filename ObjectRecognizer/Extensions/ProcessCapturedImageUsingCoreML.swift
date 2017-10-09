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

extension CameraVC: AVCapturePhotoCaptureDelegate, AVSpeechSynthesizerDelegate {
    
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
                debugPrint(error)
            }
            
            let image = UIImage(data: photoData!)
            self.capturedImageView.image = image
        }
    }
    
    internal func resultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        for classification in results {
            if classification.confidence < 0.5 {
                let unknownMessage = "Not sure what this is. Please try again!"
                self.objectNameLabel.text = unknownMessage
                self.confidenceLabel.text = ""
                synthesizeSpeech(from: unknownMessage)
            } else {
                let objectIdentifier = classification.identifier
                let confidence = Int(classification.confidence * 100)
                self.objectNameLabel.text = objectIdentifier
                self.confidenceLabel.text = "CONFIDENCE: \(confidence)%"
                let completeMessage = "I think this looks like a \(objectIdentifier), maybe \(confidence) percent sure."
                synthesizeSpeech(from: completeMessage)
                break
            }
        }
    }
    
    internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.cameraView.isUserInteractionEnabled = true
        self.spinner.stopAnimating()
//        self.spinner.isHidden = true
    }
    
    internal func synthesizeSpeech(from string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
    
}
