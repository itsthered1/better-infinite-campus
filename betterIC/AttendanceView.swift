//
//  AttendanceView.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/3/23.
//

import SwiftUI

struct AttendanceView: View {
    
    @State private var root: [Quarter] = []
    
    init() {
        
    }
    
    var body: some View {
        NavigationStack {
            // Show the List only if data is available
            if !root.isEmpty {
                List(root[0].courses) { course in
                    Text(course.name)
                }.navigationTitle("Attendance")
            } else {
                Text("Could not connect to Infinite Campus.")
            }
        }
        .onAppear {
//            let getData = GetData()
//            getData.fetch(from: "http://localhost:3000/api/attendance") { result in
//                switch result {
//                    case .success(let data):
//                        do {
//                            let decoder = JSONDecoder()
//                            let decodedRoot = try decoder.decode([Quarter].self, from: data)
//                            // Handle decoded data
//                        } catch {
//                            // Handle decoding error
//                        }
//                    case .failure(let error):
//                        print(error)
//                }
//            }
        }
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}
