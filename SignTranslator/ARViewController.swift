//
//  ARViewController.swift
//  SignTranslator
//
//  Created by Thomas on 28/1/2024.
//

import UIKit
import CoreML
import ARKit
import Vision
import SceneKit

class ARViewController: UIViewController,ARSessionDelegate {

    private(set) var results: String?
    var textLabel: UILabel!
    var clearButton: UIButton!
    //    var arView: ARView!
    var arScnView: ARSCNView!
    var frameCounter: Int = 0
    let handPosePredictionInterval: Int = 30
    var model = try? SignLanguageClassifier(configuration: MLModelConfiguration())
    var viewWidth:Int = 0
    var viewHeight:Int = 0
    var currentHandPoseObservation: VNHumanHandPoseObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        arScnView = ARSCNView(frame: view.bounds)
        view.addSubview(arScnView)
        viewWidth = Int(arScnView.bounds.width)
        viewHeight = Int(arScnView.bounds.height)

        let config = ARFaceTrackingConfiguration()
        arScnView.session.delegate = self
        arScnView.session.run(config, options: [.removeExistingAnchors])

        // Initialize text field
        textLabel = UILabel(frame: CGRect(x: 20, y: 50, width: view.bounds.width - 40, height: 100))
        textLabel.textAlignment = .center
        textLabel.textColor = .white
        textLabel.backgroundColor = .black
        textLabel.text = ""
        textLabel.numberOfLines = 4
        textLabel.lineBreakMode = .byWordWrapping

        // Initialize button
        let clearButton = UIButton(frame: CGRect(x: 20, y:150, width: 40, height: 40))
        clearButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        clearButton.backgroundColor = .blue
        clearButton.tintColor = .white
        clearButton.layer.cornerRadius = 6
        clearButton.addTarget(self, action:#selector(clearText), for: .touchUpInside)

        // Add the label and button to the view
        view.addSubview(textLabel)
        view.addSubview(clearButton)
    }

    @objc func clearText() {
        textLabel.text = ""
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let pixelBuffer = frame.capturedImage
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            let handPoseRequest = VNDetectHumanHandPoseRequest()
            handPoseRequest.maximumHandCount = 1
            handPoseRequest.revision = VNDetectHumanHandPoseRequestRevision1
            
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,orientation: .right , options: [:])
            do {
                try handler.perform([handPoseRequest])
            } catch {
                assertionFailure("HandPoseRequest failed: \(error)")
            }
            
            guard let handPoses = handPoseRequest.results, !handPoses.isEmpty else { return }
            
            guard let observation = handPoses.first else { return }
            currentHandPoseObservation = observation
            frameCounter += 1
            if frameCounter % handPosePredictionInterval == 0 {
                frameCounter = 0
                makePrediction(handPoseObservation: observation)
            }
        }
    }
    
    func makePrediction(handPoseObservation: VNHumanHandPoseObservation) {
        guard let keypointsMultiArray = try? handPoseObservation.keypointsMultiArray() else { fatalError() }
        do {
            let prediction = try model!.prediction(poses: keypointsMultiArray)
            let label = prediction.label
            guard let confidence = prediction.labelProbabilities[label] else { return }
            print("label:\(prediction.label)\nconfidence:\(confidence)")
            if confidence > 0.9 {
                DispatchQueue.main.async { [self] in
   
                    if label == "space" {
                        textLabel.text = textLabel.text! + " "
                    } else if label == "del" && textLabel.text! != ""{
                        textLabel.text!.removeLast()
                    } else if label == "del" && textLabel.text! == ""{
                        
                    }else {
                        textLabel.text = textLabel.text! + label
                    }
                }
            }
        } catch {
            print("Prediction error")
        }
    }
    
    func getHandPosition(handPoseObservation: VNHumanHandPoseObservation) -> SCNVector3? {
        guard let indexFingerTip = try? handPoseObservation.recognizedPoints(.all)[.indexPIP],
              indexFingerTip.confidence > 0.3 else {return nil}
        let deNormalizedIndexPoint = VNImagePointForNormalizedPoint(CGPoint(x: indexFingerTip.location.x, y:1-indexFingerTip.location.y), viewWidth,  viewHeight)
        let infrontOfCamera = SCNVector3(x: 0, y: 0, z: -0.2)
        guard let cameraNode = arScnView.pointOfView else { return nil}
        let pointInWorld = cameraNode.convertPosition(infrontOfCamera, to: nil)
        var screenPos = arScnView.projectPoint(pointInWorld)
        screenPos.x = Float(deNormalizedIndexPoint.x)
        screenPos.y = Float(deNormalizedIndexPoint.y)
        let finalPosition = arScnView.unprojectPoint(screenPos)
        print(finalPosition)
        return finalPosition
    }

}
