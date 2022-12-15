//
//  LockScreenViewController.swift
//  Notes
//
//  Created by Sai Palutla on 12/13/22.
//

import Foundation
import UIKit
import LocalAuthentication

class LockScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var context = LAContext()
        
        var error: NSError?

        // Check for biometric authentication
        // permissions
        var permissions = context.canEvaluatePolicy(
            .deviceOwnerAuthentication,
            error: &error
        )

        if permissions {
            // Proceed to authentication
            let reason = "Log in with Face ID"
            context.evaluatePolicy(
                // .deviceOwnerAuthentication allows
                // biometric or passcode authentication
                .deviceOwnerAuthentication,
                localizedReason: reason
            ) { success, error in
                if success {
                    // Handle successful authentication
                    DispatchQueue.main.async {
                        let controller = self.storyboard?.instantiateViewController(identifier: "NavViewController") as! UINavigationController
                        controller.modalPresentationStyle = .fullScreen
                        self.present(controller, animated: false)
                    }
                    
                } else {
                    // Handle LAError error
                }
            }

        }
        else {
            // Handle permission denied or error
        }
        
    }
    
}

