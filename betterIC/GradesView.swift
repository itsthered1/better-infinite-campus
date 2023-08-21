//
//
//  GradesView.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/3/23.
//

import SwiftUI
import Foundation

//main list
struct GradesView: View {
    @State private var root: [Quarter] = []
    @State private var inQuarter: Int = 0
    
    var body: some View {
        NavigationStack {
            // Show the List only if data is available
            if !root.isEmpty {
                List {
                    ForEach(Array(root[inQuarter].courses.enumerated()), id: \.element._id) { (index, course) in
                        CourseElement(root: $root,
                                      inQuarter: $inQuarter,
                                      courseIndex: index,
                                      courseName: course.name,
                                      teacher: course.teacher)
                    }
                }.navigationTitle("Your Courses")
            } else {
                Text("No courses available. Check back later.")
            }
            
        }
        .onAppear {
            let getData = GetData()
            getData.processData { processedRoot in
                self.root = processedRoot
                self.inQuarter = getData.findQuarter()
            }
        }
    }
}

//list element
struct CourseElement: View {
    @Binding var root: [Quarter]
    @Binding var inQuarter: Int
    
    let courseIndex: Int
    let courseName: String
    let teacher: String
    
    var body: some View {
        NavigationLink(destination: GradesExpanded(root: $root, inQuarter: $inQuarter, courseIndex: courseIndex)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(teacher + " - Q" + String(inQuarter + 1))
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(courseName)
                        .font(.headline)
                        .bold()
                }
                Spacer()
                Text(root[inQuarter].courses[courseIndex].grades?.score ?? "N/A")
            }
        }
    }
}

//details
struct GradesExpanded: View {
    @Binding var root: [Quarter]
    @Binding var inQuarter: Int
    let courseIndex: Int
    
    @State private var selectedType = 0
    @State private var termType = 0
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading){
                    if selectedType == 0 {
                        Text("Quarter Grade:")
                            .fontWeight(.medium)
                            .font(.system(size: 24))
                            .padding(.top, 18)
                    } else {
                        Text("Semester Grade:")
                            .fontWeight(.medium)
                            .font(.system(size: 24))
                            .padding(.top, 18)
                    }
                    if let percent = root[termType].courses[courseIndex].grades?.percent {
                        Text("\(percent)%")
                            .fontWeight(.bold)
                            .font(.system(size: 52))
                    } else {
                        Text("N/A")
                            .fontWeight(.bold)
                            .font(.system(size: 52))
                    }
                    Picker("select", selection: $selectedType) {
                        Text("Quarter").tag(0)
                        Text("Semester").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .offset(x:0, y: -22)
                    .frame(width:185)
                }
                .padding(.leading, 18.0)
                Spacer()
                ZStack {
                    if let score = root[termType].courses[courseIndex].grades?.score {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 130, height: 130)
                            .foregroundStyle(.green)
                        Text("\(score)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 64))
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 130, height: 130)
                            .foregroundStyle(.gray)
                        Text("?")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 64))
                    }
                }
                .padding(.top, 22)
                .padding(.trailing, 18)
                .offset(x:-10, y:0)
            }
            Picker("select", selection: $termType) {
                if selectedType == 0 {
                    Text("Q1").tag(0)
                    Text("Q2").tag(1)
                    Text("Q3").tag(2)
                    Text("Q4").tag(3)
                } else {
                    Text("S1").tag(0)
                    Text("S2").tag(1)
                }
            }
            .padding([.leading, .trailing], 18)
            //.border(.gray)
            .pickerStyle(.segmented)
            .offset(x:0, y: -45)
            
            if !root[inQuarter].courses[courseIndex].assignments.isEmpty {
                List {
                    Section(header: Text("Assignments:")) {
                        ForEach(Array(root[inQuarter].courses[courseIndex].assignments.enumerated()), id: \.element._id) { (index, assignment) in
                            AssignmentElement(assignment: assignment)
                        }
                    }
                }
                .padding(.bottom, -45)
                .onAppear {
                    print("Assignments available")
                }
                .offset(x:0, y:-35)
            } else {
                List {
                    Section(header: Text("No assignments yet")) {
                        
                    }
                }
                .padding(.bottom, -45)
                .onAppear {
                    print("No assignments available")
                }
                .offset(x:0, y:-35)
            }
        }
        .navigationTitle(root[inQuarter].courses[courseIndex].name)
    }
}

struct AssignmentElement: View {
    @State var assignment: Assignments
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text(assignment.category)
                .font(.footnote)
                .foregroundColor(.gray)
            Text(assignment.name)
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}

struct GradesView_Previews: PreviewProvider {
    static var previews: some View {
        GradesView()
    }
}
