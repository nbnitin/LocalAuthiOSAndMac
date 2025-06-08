//
//  ContentView.swift
//  LocalAuthenticationDemo
//
//  Created by Nitin Bhatia on 08/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated: Bool = false
    @State private var showAlert: Bool = false
    @State private var desc: String = ""
    
    var body: some View {
        VStack {
            Button("Authenticate") {
                UsingEmbeddedUI(completion: {(status)  in
                    self.isAuthenticated = status.status
                    self.desc = status.desc ?? ""
                    showAlert.toggle()
                })
            }
            
            Button("Authenticate Without Embedded UI") {
                WithoutUsingEmbeddedUI(completion: {(status, message) in
                    self.isAuthenticated = status
                    self.desc = message ?? ""
                    showAlert.toggle()
                })
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Status \(isAuthenticated ? "Success" : "Failed")"),
                message: Text(desc),
                dismissButton: .cancel(Text("OK"), action: {
                    showAlert.toggle()
                    isAuthenticated.toggle()
                })
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
