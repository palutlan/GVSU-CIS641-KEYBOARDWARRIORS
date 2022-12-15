//
//  EditNoteViewController.swift
//  MyNotes
//
//  Created by Sai Palutla on 25/10/2022.
//

import UIKit
import Vision
import VisionKit

class EditViewController: UIViewController {
    
    static let identifier = "EditNoteViewController"
    
    var note: Note!
    weak var delegate: ListNotesDelegate?
    private var ocrRequest = VNRecognizeTextRequest(completionHandler: nil)

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak private var textView: UITextView!
    
    @IBAction func scanTextTapped(_ sender: Any) {
        let scanVC = VNDocumentCameraViewController()
        scanVC.delegate = self
        present(scanVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note?.text
        initializeHideKeyboard()
        configureOCR()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func updateNote() {
        CoreDataHelper.manager.save()
        note.lastUpdated = Date()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        delegate?.deleteNote(with: note.id!)
        CoreDataHelper.manager.deleteNote(note)
    }
    
    
    
    private func processImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }

//        self.textView.text = ""
        scanButton.isEnabled = false
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try requestHandler.perform([self.ocrRequest])
        } catch {
            print(error)
        }
    }

    
    private func configureOCR() {
        ocrRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var ocrText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { return }
                
                ocrText += topCandidate.string + "\n"
            }
            
            
            DispatchQueue.main.async {
                self.textView.text += ("\n" + ocrText)
                self.scanButton.isEnabled = true
            }
        }
        
        ocrRequest.recognitionLevel = .accurate
        ocrRequest.recognitionLanguages = ["en-US", "en-GB"]
        ocrRequest.usesLanguageCorrection = true
    }
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        textView.addGestureRecognizer(swipe)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
}


extension EditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
}

extension EditViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount >= 1 else {
            controller.dismiss(animated: true)
            return
        }
        
        processImage(scan.imageOfPage(at: 0))
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        //Handle properly error
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}
