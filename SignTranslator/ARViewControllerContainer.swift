//
//  ARViewControllerContainer.swift
//  SignTranslator
//
//  Created by Thomas on 28/1/2024.
//

import Foundation
import SwiftUI
import RealityKit

struct ARViewControllerContainer: UIViewControllerRepresentable {
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<ARViewControllerContainer>) -> ARViewController {
        let viewController = ARViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: UIViewControllerRepresentableContext<ARViewControllerContainer>) {
        
    }
    
    func makeCoordinator() -> ARViewControllerContainer.Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject {
        
    }
}
