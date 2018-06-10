//
//  CustomizedScannerView.swift
//  BlockchainQRScanner
//
//  Created by Shawn Hung on 2018/6/10.
//  Copyright © 2018 abclab. All rights reserved.
//

import UIKit

class CustomizedScannerView: UIView, QRCodeReaderDisplayable {
    
    
    let cameraView: UIView            = UIView()
    let cancelButton: UIButton?       = UIButton()
    let switchCameraButton: UIButton? = SwitchCameraButton()
    let toggleTorchButton: UIButton?  = ToggleTorchButton()
    var overlayView: UIView?          = UIView()

    
    func setNeedsUpdateOrientation() {
    }
    
    func setupComponents(showCancelButton: Bool, showSwitchCameraButton: Bool, showTorchButton: Bool, showOverlayView: Bool, reader: QRCodeReader?) {
        
    }
}
