//
//  StyleDetection.swift
//  ArtApp
//
//  Created by Anna on 26.06.2023.
//

import Foundation
import MLKit
import Vision

class StyleDetection{
    private let classifier: VNCoreMLModel
    init() {
        guard let model = try? ArtClassifier(configuration: MLModelConfiguration()) else {
            fatalError("Cannt create mobile net v2")
        }

        guard let localClassifier = try? VNCoreMLModel(for: model.model) else {
            fatalError("Cannt create vn core mobile")

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
