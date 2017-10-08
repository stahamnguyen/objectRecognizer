//
//  ViewController.swift
//  ObjectRecognizer
//
//  Created by Staham Nguyen on 08/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {
    
    @IBOutlet weak var infoBackgroundView: CustomView!
    @IBOutlet weak var capturedImageView: CustomImageView!
    @IBOutlet weak var toggleFlashButton: CustomButton!
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

