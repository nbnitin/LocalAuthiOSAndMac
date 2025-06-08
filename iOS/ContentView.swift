//
//  ContentView.swift
//  LocalAuthenticationDemoiPhone
//
//  Created by Nitin Bhatia on 08/06/25.
//

//Make sure you added this to your Info.plist:
//<key>NSFaceIDUsageDescription</key>
//<string>We use Face ID to authenticate you.</string>

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isAuthenticated = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text(isAuthenticated ? "✅ Authenticated" : "🔒 Not Authenticated")
                .font(.title)

            Button("Authenticate") {
                authenticateUser()
            }

            if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }

    func authenticateUser() {
        let context = LAContext()
        context.localizedFallbackTitle = "Use Passcode"
        context.interactionNotAllowed = false

        var error: NSError?
        let reason = "Authenticate using Face ID or Passcode"

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        isAuthenticated = true
                        errorMessage = nil
                    } else {
                        errorMessage = authError?.localizedDescription ?? "Unknown error"
                    }
                }
            }
        } else {
            errorMessage = error?.localizedDescription ?? "Biometrics not available"
        }
    }
}

#Preview {
    ContentView()
}
