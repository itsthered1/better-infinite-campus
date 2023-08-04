//
//  GetData.swift
//  betterIC
//
//  Created by Claudio Rojas on 8/3/23.
//

import Foundation

struct Quarter: Decodable {
    let name: String
    let seq: Int
    let startDate: String
    let endDate: String
    let courses: [Course]
    let placement: Placement?
    // Additional properties if needed
}

struct Course: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let courseNumber: String
    let roomName: String
    let teacher: String
    let _id: String
    // Additional properties if needed
}

struct Placement: Decodable {
    let periodName: String
    let periodSeq: Int
    let startTime: String
    let endTime: String
    // Additional properties if needed
}

struct Grades: Decodable {
    let id = UUID()
    let percent: Int
    let score:  String
}

class GetData {
    func fetch (from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {                    completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "Data not found", code: 0, userInfo: nil)))
                }
                
                
            }.resume()
        }

    }
}
