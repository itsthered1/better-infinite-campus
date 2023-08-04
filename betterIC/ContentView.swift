//
//  ContentView.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        if !isLoggedIn {
            AuthView(isLoggedIn: $isLoggedIn)
        } else {
            TabView {
                GradesView()
                    .tabItem{
                        Label("Grades", systemImage: "graduationcap")
                    }
                AttendanceView()
                    .tabItem{
                        Label("Attendance", systemImage: "hand.raised")
                    }
                YouView()
                    .tabItem{
                        Label("You", systemImage: "person")
                    }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
