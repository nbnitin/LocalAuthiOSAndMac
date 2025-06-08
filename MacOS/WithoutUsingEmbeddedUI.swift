//
//  WithoutUsingEmbeddedUI.swift
//  LocalAuthenticationDemo
//
//  Created by Nitin Bhatia on 08/06/25.
//

import SwiftUI
import LocalAuthentication

func WithoutUsingEmbeddedUI(completion: @escaping (Bool, String?) -> Void) {
    let context = LAContext()
    context.localizedFallbackTitle = "Use Password"
    context.interactionNotAllowed = false // Required for embedded UI (macOS 13+)
    
    var authError: NSError?
    let reason = "Please authenticate to proceed"
    
    if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
            DispatchQueue.main.async {
                if success {
                    completion(true, nil)
                } else {
                    let message = evaluateError?.localizedDescription ?? "Authentication failed"
                    completion(false, message)
                }
            }
        }
    } else {
        let message = authError?.localizedDescription ?? "Cannot evaluate policy"
        completion(false, message)
    }
}



