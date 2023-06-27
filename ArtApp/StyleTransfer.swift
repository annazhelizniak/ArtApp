//
//  StyleTransfer.swift
//  ArtApp
//
//  Created by Anna on 26.06.2023.
//

import Foundation
import UIKit

import Vision
import CoreML

class StyleTransferProcessor {
    private let transfer: VNCoreMLModel
    
    init(style:String) {
        switch style{
        case "style 1": do {
            guard let model = try? style1(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("1")
            transfer = t
        }
        case "style 2": do {
            guard let model = try? style2(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("2")
            transfer = t
        }
        case "style 3": do {
            guard let model = try? style3(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("3")
            transfer = t
        }
        case "style 4": do {
            guard let model = try? style4(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("4")
            transfer = t
        }
        case "style 5": do {
            guard let model = try? style1(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("5")
            transfer = t
        }
        default :
            print("default")
            fatalError("Style wasn't detected")
        
        }

    }
        func stylize(image: UIImage, completion: @escaping (UIImage?) -> Void) {
            let request = VNCoreMLRequest(model: self.transfer) { request, error in
                guard let results = request.results as? [VNPixelBufferObservation],
                      let observation = results.first
                else {
                    print("No results: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                let styleTransferredImage = UIImage(ciImage: CIImage(cvPixelBuffer: observation.pixelBuffer))
                DispatchQueue.main.async {
                    completion(styleTransferredImage)
                }
            }
    
            if let cgImage = image.cgImage {
                let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    try handler.perform([request])
                } catch {
                    print("Failed to perform request: \(error)")
                    completion(nil)
                }
            }
        }
    
}
