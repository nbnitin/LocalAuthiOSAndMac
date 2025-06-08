//
//  UsingEmbeddedUI.swift
//  LocalAuthenticationDemo
//
//  Created by Nitin Bhatia on 08/06/25.
//

import SwiftUI
import LocalAuthenticationEmbeddedUI

func UsingEmbeddedUI(completion: @escaping ((status: Bool, desc: String?)) -> Void) {
    let context = LAContext()
    context.localizedReason = "Authenticate to unlock the app"
    context.interactionNotAllowed = false // Allow user interaction
    //this has few more option .deviceOwnerAuthentication
    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate") { success, error in
        if success {
            completion((true, success.description))
        } else {
            completion((false, error?.localizedDescription))
        }
    }
}



