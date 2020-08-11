//
//  MarsRover.swift
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/6/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

class MarsRover: NSObject, Codable {
    let name: String

    let launchDate: Date
    let landingDate: Date

    enum Status: String, Codable {
        case active, complete
    }
    let status: Status

    let maxSol: Int
    let maxDate: Date

    let numberOfPhotos: Int

    let solDescriptions: [SolDescription]

    enum CodingKeys: String, CodingKey {
        case name
        case launchDate
        case landingDate
        case status
        case maxSol
        case maxDate
        case numberOfPhotos = "totalPhotos"
        case solDescriptions = "photos"
    }

    @objc static func newRover(from data: Data) -> MarsRover? {
        do {
            return try jsonDecoder.decode(self, from: data)
        } catch {
            print("Error decoding rover!")
            dump(error)
            return nil
        }
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static var jsonDecoder: JSONDecoder {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}
