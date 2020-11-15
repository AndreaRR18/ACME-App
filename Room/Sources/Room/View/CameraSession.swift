import Foundation
import AVFoundation

protocol CameraSession {
    var previewFrame: CGRect { get }
    var captureSession: AVCaptureSession { get }
    var stillImageOutput: AVCapturePhotoOutput { get }
    
    func setupLivePreview()
}

extension CameraSession {
    func frontCamerarRunning() {
        captureSession.sessionPreset = .medium
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.startRunning()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func frontCameraStop() {
        captureSession.stopRunning()
        
    }
}

