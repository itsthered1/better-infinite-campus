//
//  AuthView.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/3/23.
//

import SwiftUI

struct AuthView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
                .padding()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                // You can add your authentication logic here
                isLoggedIn = true // Simulating successful login
            }) {
                Image(systemName: "arrow.right")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            if isLoggedIn {
                Text("Logged in successfully!")
                    .foregroundColor(.green)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
}

//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
//}
