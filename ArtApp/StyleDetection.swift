//
//  StyleDetection.swift
//  ArtApp
//
//  Created by Anna on 16.06.2023.
//

import Foundation
import CoreML
import Vision
import UIKit

class StyleDetection{
    private let classifier: VNCoreMLModel
    init() {
        guard let model = try? ArtClassifier2(configuration: MLModelConfiguration()) else {
            fatalError("Creating error")
        }
        
        guard let localClassifier = try? VNCoreMLModel(for: model.model) else {
            fatalError("Creating error")
            
        }
        classifier = localClassifier
    }
    
    func process(image: UIImage, onResult: @escaping ([String:Float]) -> Void) {
        let visionRequest = VNCoreMLRequest(model: classifier) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                onResult([:])
                return
            }
            let sequence = result.map {
                let label = $0.identifier
                let data = $0.confidence
                return (label, data)
            }
            let dictionary = Dictionary(uniqueKeysWithValues: sequence)
            onResult(dictionary)
        }
        guard let cgImage = image.cgImage else {
            fatalError("cant get cg image")
        }
        let visionHandler = VNImageRequestHandler(cgImage: cgImage)

        guard (try? visionHandler.perform([visionRequest])) != nil else {
            fatalError("Cant process handler")
        }
    }
}

