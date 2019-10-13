//
//  ViewController.swift
//  CoreMLSimple
//
//  Created by 杨萧玉 on 2017/6/9.
//  Copyright © 2017年 杨萧玉. All rights reserved.
//
//  Modified and used based on MIT license (look for ML_License.md in parent folder)

import UIKit
import CoreMedia
import Vision

private let goBackSegue: String = "GoBackFromMLSegue"


/// ViewController used to display Classificator challenge from Earth
/// This controller needs to be injected with ClassificationTask.
class CoreMLViewController: UIViewController, UIImagePickerControllerDelegate {
    
    // Outlets to label and view
    @IBOutlet private weak var predictLabel: UILabel!
    @IBOutlet private weak var previewView: UIView!
    @IBOutlet private weak var earthView: EarthView!
    @IBOutlet private weak var textBubbule: TextBubbleView!
    @IBOutlet private weak var categoryicon: UIImageView!
    @IBOutlet private weak var correctView: AnswerCorrectView!
    @IBOutlet private weak var infoButton: StartButton!
    
    var task: ClassificationTask!
    
    
    // some properties used to control the app and store appropriate values
    let inceptionv3model = Inceptionv3()
    private var videoCapture: VideoCapture!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryicon.layer.opacity = 0.0
        categoryicon.transform = categoryicon.transform.scaledBy(x: 0.2, y: 0.2)
        let tap: UIGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleIconTap))
        categoryicon.addGestureRecognizer(tap)
        categoryicon.isUserInteractionEnabled = true
        categoryicon.isHidden = true
        
        infoButton.addTarget(self, action: #selector(handleURL), for: .touchUpInside)
        
        let tap2: UIGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(goBack))
        correctView.addGestureRecognizer(tap2)
        
        textBubbule.set(arrowPlace: .left)
        textBubbule.display(text: task.bubbleText)
        
        
        // Starts capturing video and checks every frame with InceptionV3 classifier.
        let spec = VideoSpec(fps: 2, size: CGSize(width: 299, height: 299))
        videoCapture = VideoCapture(cameraType: .back,
                                    preferredSpec: spec,
                                    previewContainer: previewView.layer
        )
        videoCapture.imageBufferHandler = {[unowned self] (imageBuffer) in
                self.handleImageBufferWithCoreML(imageBuffer: imageBuffer)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        earthAnimation()
    }
    
    
    /// Check image for one of classified in InceptionV3 object, maps it to Classifier, and compare if it fits current task
    func handleImageBufferWithCoreML(imageBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(imageBuffer) else {
            return
        }
        do {
            let prediction = try self.inceptionv3model.prediction(image: self.resize(pixelBuffer: pixelBuffer)!)
            DispatchQueue.main.async {
                if let prob = prediction.classLabelProbs[prediction.classLabel],
                    prob > 0.5,
                    let classifier = Classifier.init(mapPrediction: prediction.classLabel),
                    self.task.possibleElements.contains(classifier) {
                    
                        self.videoCapture.stopCapture()
                        self.categoryicon.image = self.task.category.icon
                        self.showCategory()
                        self.predictLabel.text = "Wykryto: \(classifier.rawValue)"
                    }
                }
            }
        catch let error as NSError {
            fatalError("Unexpected error ocurred: \(error.localizedDescription).")
        }
    }
    
    
    /// resize CVPixelBuffer
    ///
    /// - Parameter pixelBuffer: CVPixelBuffer by camera output
    /// - Returns: CVPixelBuffer with size (299, 299)
    func resize(pixelBuffer: CVPixelBuffer) -> CVPixelBuffer? {
        let imageSide = 299
        var ciImage = CIImage(cvPixelBuffer: pixelBuffer, options: nil)
        let transform = CGAffineTransform(scaleX: CGFloat(imageSide) / CGFloat(CVPixelBufferGetWidth(pixelBuffer)), y: CGFloat(imageSide) / CGFloat(CVPixelBufferGetHeight(pixelBuffer)))
        ciImage = ciImage.transformed(by: transform).cropped(to: CGRect(x: 0, y: 0, width: imageSide, height: imageSide))
        let ciContext = CIContext()
        var resizeBuffer: CVPixelBuffer?
        CVPixelBufferCreate(kCFAllocatorDefault, imageSide, imageSide, CVPixelBufferGetPixelFormatType(pixelBuffer), nil, &resizeBuffer)
        ciContext.render(ciImage, to: resizeBuffer!)
        return resizeBuffer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let videoCapture = videoCapture else {return}
        videoCapture.startCapture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let videoCapture = videoCapture else {return}
        videoCapture.resizePreview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let videoCapture = videoCapture else {return}
        videoCapture.stopCapture()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    /// Adds Earth continous jump animation
    private func earthAnimation() {
        earthView.transform = CGAffineTransform.identity
        UIView.animate(
            withDuration: TimeInterval(0.7),
            delay: TimeInterval(0.0),
            usingSpringWithDamping: CGFloat(0.99),
            initialSpringVelocity: CGFloat(0.3),
            options: [
                UIView.AnimationOptions.autoreverse,
                UIView.AnimationOptions.repeat,
                UIView.AnimationOptions.allowUserInteraction,
                UIView.AnimationOptions.curveEaseOut
            ],
            animations: {
                self.earthView.transform = CGAffineTransform.init(translationX: 0, y: -20)
        }
        )
    }
    
    @objc private func handleIconTap() {
        MainModel.instace.correctAnswer()
        correctView.isHidden = false
        correctView.success(he: true)
        correctView.asd()
    }
    
    @objc private func handleURL() {
        if let url: URL = task.funnyUrl {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    /// Animates showing of category associated with task when succesfully scaned object.
    private func showCategory() {
        self.categoryicon.isHidden = false
        self.infoButton.layer.opacity = 0.0
        self.infoButton.isHidden = (task.funnyUrl == nil)
        UIView.animate(
            withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3,
            options: [],
            animations: {
                self.categoryicon.layer.opacity = 1.0
                self.categoryicon.transform = CGAffineTransform.identity
                self.infoButton.layer.opacity = 1.0
            },
            completion: nil
        )
        
    }
    
    
    // needed for layout
    override func viewWillLayoutSubviews() {
        textBubbule.preferredMaxLayoutWidth = self.view.bounds.width - earthView.bounds.width - 15
    }
    
    
    // performs unwind segue
    @objc private func goBack() {
        performSegue(withIdentifier: goBackSegue, sender: nil)
    }
    
    
}

