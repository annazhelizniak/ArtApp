//
//  TransferStyleController.swift
//  ArtApp
//
//  Created by Anna on 27.06.2023.
//

import Foundation
import UIKit


class TransferStyleController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    private var selectedStyle:String = "style 1"
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
    

    @IBAction func choosePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        let styleTransferProcessor = StyleTransferProcessor(style: selectedStyle)
        guard let inputImage = self.inputImage.image else {
            print("No input image")
            return
        }
        styleTransferProcessor.stylize(image: inputImage) { [weak self] stylizedImage in
            self?.outputImage.image = stylizedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    let pickerData = ["style 1", "style 2", "style 3", "style 4", "style 5"]
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
    }
}
