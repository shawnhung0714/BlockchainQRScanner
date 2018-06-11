//
//  ViewController.swift
//  BlockchainQRScanner
//
//  Created by Shawn Hung on 2018/6/10.
//  Copyright © 2018 abclab. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
import PKHUD
import Alamofire

class ViewController: UIViewController {
        
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        builder.showCancelButton = false
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    var hasShown = false
    
    var isSending = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasShown {
            let navigationController = UINavigationController(rootViewController: readerVC)
            readerVC.title = "進階比對"
            navigationController.navigationBar.barTintColor = UIColor.blue
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
            present(navigationController, animated: true, completion: nil)
            hasShown = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : QRCodeReaderViewControllerDelegate {
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        
        if !isSending {
            let parameters: Parameters = ["qr": result.value]
            
            Alamofire.request("http://140.112.29.201:51502/5bd3bA83/get", method:.post, parameters:parameters).response {response in
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    HUD.flash(.label("Success \(utf8Text) times!"), delay: 1, completion:{ success in
                        if success {
                            self.isSending = false
                        }
                    })
                }
            }
            
            isSending = true
        }
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        let cameraName = newCaptureDevice.device.localizedName
        print("Switching capturing to: \(cameraName)")
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        dismiss(animated: true, completion: nil)
    }
}

