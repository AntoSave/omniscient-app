//
//  OrientationHelper.swift
//  omniscient
//
//  Created by DAVIDE RISI on 02/06/22.
//

import Foundation

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask = .portrait) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask = .portrait, andRotateTo rotateOrientation:UIInterfaceOrientation = .portrait) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
