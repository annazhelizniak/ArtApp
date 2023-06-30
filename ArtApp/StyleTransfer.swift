//
//  StyleTransfer.swift
//  ArtApp
//
//  Created by Anna on 16.06.2023.
//

import Foundation
import UIKit

import Vision
import CoreML

class StyleTransferProcessor {
    private let transfer: VNCoreMLModel
    
    init(style:String) {
        switch style{
        case "futurism": do {
            guard let model = try? futurism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("1")
            transfer = t
        }
        case "impressionism": do {
            guard let model = try? impressionism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("2")
            transfer = t
        }
        case "surrealism": do {
            guard let model = try? surrealism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("3")
            transfer = t
        }
        case "popart": do {
            guard let model = try? popArt(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("3")
            transfer = t
        }
        case "academicism": do {
            guard let model = try? academicism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("4")
            transfer = t
        }
        case "magic realism": do {
            guard let model = try? magic_realism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("5")
            transfer = t
        }
        case "japanism": do {
            guard let model = try? japanism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("5")
            transfer = t
        }
        case "naturalism": do {
            guard let model = try? naturalism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            transfer = t
        }
        case "expressionism": do {
            guard let model = try? expressionism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            transfer = t
        }
        case "cubism": do {
            guard let model = try? cubism(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            transfer = t
        }
        case "neobaroko": do {
            guard let model = try? neobaroko(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            transfer = t
        }
        case "vangog": do {
            guard let model = try? vangog(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            transfer = t
        }
        case "picasso": do {
            guard let model = try? picasso(configuration: MLModelConfiguration()) else {
                fatalError("Creating error")
            }
            
            guard let t = try? VNCoreMLModel(for: model.model) else {
                fatalError("Creating error")
                
            }
            print("picasso")
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
            
            let ciImage = CIImage(cvPixelBuffer: observation.pixelBuffer)
            let context = CIContext(options: nil)
            if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
                let styleTransferredImage = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    completion(styleTransferredImage)
                }
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
