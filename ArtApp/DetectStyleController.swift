//
//  DetectDataController.swift
//  ArtApp
//
//  Created by Anna on 25.06.2023.
//

import Foundation

import UIKit

class DetectStyleController: UIViewController {
    private lazy var styleDetection = StyleDetection()
//    private lazy var styleTransfer = styleTransfer()
    
    @IBOutlet private weak var inputImage: UIImageView!{
        didSet {
            inputImage.image = UIImage(named: "DefaultInput")
        }
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            print("Camera not available")
            return
        }
        present(picker, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension DetectStyleController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("error getting image")
        }
        picker.dismiss(animated: true)

        self.inputImage.image = image
//        styleTransfer.
//        styleDetection.process(image: image) { (dict) in
//            let result = dict.sorted { $0.value > $1.value }.first
//            print("MLKit result: \(String(describing: result))")
//        }
    }
}
