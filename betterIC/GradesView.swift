//
//
//  GradesView.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/3/23.
//

import SwiftUI
import Foundation

struct GradesView: View {
    @State private var root: [Quarter] = []
    @State private var inQuarter: Int = 0
    
    var body: some View {
        NavigationStack {
            // Show the List only if data is available
            if !root.isEmpty {
                List(root[0].courses) { course in
                    CourseElement(courseName: course.name, teacher: course.teacher, letterGrade: "N/A", quarter: root[0].name)
                }.navigationTitle("Your Courses")
            } else {
                Text("No courses available. Check back later.")
            }
            
        }
        .onAppear {
            let getData = GetData()
            getData.fetch(from: "http://localhost:3000/api/courses") { result in
                switch result {
                    case .success(let data):
                    print("got data")
                        do {
                            let decoder = JSONDecoder()
                            let decodedRoot = try decoder.decode([Quarter].self, from: data)
                            self.root = decodedRoot
                            print(root)
                        } catch {
                            // Handle decoding error
                        }
                    case .failure(let error):
                        print(error)
                }
            }
            
            //we have our data for each quarter in root. however, we don't know what quarter we are in
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-mm-dd"
//            let currentDate = Date()
//
//            if currentDate >= dateFormatter.date(from: root[3].startDate) {
//                inQuarter = 4
//            } else if currentDate >= root[2].startDate {
//                inQuarter = 3
//            } else if currentDate >= root[1].startDate {
//                inQuarter = 2
//            } currentDate >= root[3].startDate {
//                inQuarter = 1
//            }
        }
    }
}

struct CourseElement: View {
    let courseName: String
    let teacher: String
    let letterGrade: String
    let quarter: String
    
    var body: some View {
        NavigationLink(destination: GradesExpanded()) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(teacher + " - " + quarter)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(courseName)
                        .font(.headline)
                        .bold()
                }
                Spacer()
                Text(letterGrade)
            }
        }
    }
}

struct GradesExpanded: View {
    @State private var root: [Quarter] = []
    
    var body: some View {
        VStack {
            Text("Grades")
        }
    }
}

struct GradesView_Previews: PreviewProvider {
    static var previews: some View {
        GradesView()
    }
}
