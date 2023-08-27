//
//  AttendanceView.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/3/23.
//

import SwiftUI
import Foundation

struct AttendanceView: View {
    
    @State private var root: [Quarter] = []
    @State private var inTerm: Int = 0
    
    var body: some View {
        NavigationStack {
            // Show the List only if data is available
            if !root.isEmpty {
                List {
                    ForEach(Array(root[inTerm].courses.enumerated()), id: \.element.id) { (index, course) in
                        AttendanceElement(root: $root,
                                          inTerm: $inTerm,
                                          courseIndex: index)
                    }
                }
                .navigationTitle("Attendance")
            } else {
                Text("Could not connect to Infinite Campus.")
            }
        }
        .onAppear {
            let getData = GetData()
            getData.processData { processedRoot in
                self.root = processedRoot
                self.inTerm = getData.findQuarter()
            }
        }
    }
}

struct AttendanceElement: View {
    @Binding var root: [Quarter]
    @Binding var inTerm: Int
    
    let courseIndex: Int
//    let courseName: String
//    let teacher: String
//    let daysPresent: Int
//    let daysTardy: Int
//    let daysAbsent: Int
    
    
    var body: some View {
        NavigationStack {
            HStack {
                Text(root[inTerm].courses[courseIndex].name)
                    .font(.headline)
                    .bold()
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Absences: \(root[inTerm].courses[courseIndex].attendance.absences)")
                    Text("Tardies: \(root[inTerm].courses[courseIndex].attendance.tardies)")
                }
            }
            
        }
    }
}

struct AttendanceView_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceView()
    }
}
