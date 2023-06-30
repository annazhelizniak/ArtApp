//
//  TransferStyleController.swift
//  ArtApp
//
//  Created by Anna on 16.06.2023.
//

import Foundation
import UIKit


class TransferStyleController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    private var selectedStyle:String = "futurism"
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var inputImage: UIImageView!{
        didSet {
            inputImage.image = UIImage(named: "DefaultInput")
        }
    }
    
    
    @IBOutlet weak var outputImage: UIImageView!{
        didSet {
            outputImage.image = UIImage(named: "DefaultInput")
        }
    }
    
    
    @IBAction func savePicture(_ sender: Any) {
        guard let image = outputImage.image else {
            print("No image found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    

    @IBAction func share(_ sender: Any) {
        guard let image = outputImage.image else {
            print("No image found!")
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func choosePhoto(_ sender: Any) {
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
    
    
    @IBAction func submitAction(_ sender: Any) {
        print("In submitAction")
        let styleTransferProcessor = StyleTransferProcessor(style: selectedStyle)
        guard let inputImage = self.inputImage.image else {
            print("No input image")
            return
        }
        styleTransferProcessor.stylize(image: inputImage) { [weak self] stylizedImage in
            DispatchQueue.main.async {
                self?.outputImage.image = nil
                self?.outputImage.image = stylizedImage
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    let pickerData = ["futurism", "impressionism", "surrealism", "academicism", "magic realism", "japanism", "popart", "naturalism","expressionism", "cubism","neobaroko","picasso", "vangog"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        self.selectedStyle = pickerData[row]
        
    }

}
extension TransferStyleController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("error getting image")
        }
        picker.dismiss(animated: true)

        self.inputImage.image = image
        self.outputImage.image = UIImage(named: "DefaultInput")
    }
}
