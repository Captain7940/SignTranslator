//
//  ImageClassifier.swift
//  SignTranslator
//
//  Created by Thomas on 25/1/2024.
//

import SwiftUI
class ImageClassifier: ObservableObject {

 @Published private var classifier = Classifier()

 var imageClass: String? {
 classifier.results
 }

 // MARK: Intent(s)
 func detect(uiImage: UIImage) {
 guard let ciImage = CIImage (image: uiImage) else { return }
 classifier.detect(ciImage: ciImage)

 }

}
