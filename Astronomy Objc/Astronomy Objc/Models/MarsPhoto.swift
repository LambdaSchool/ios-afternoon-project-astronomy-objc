//
//  MarsPhoto.swift
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/16/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

@objc class MarsPhoto: NSObject, Decodable {
    @objc let id: Int
    @objc let sol: Int
    @objc let earthDate: String
    @objc let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case sol
        case earthDate = "earth_date"
        case imageURL = "img_src"
    }
    
    @objc init(id: Int, sol: Int, earthDate: String, imageURL: URL) {
        self.id = id
        self.sol = sol
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
    
    @objc convenience init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? Int,
            let sol = dictionary["sol"] as? Int,
            let earthDate = dictionary["earth_date"] as? String,
            let imageURLString = dictionary["img_src"] as? String,
            let imageURL = URL(string: imageURLString) else {
                return nil
        }
        
        self.init(id: id, sol: sol, earthDate: earthDate, imageURL: imageURL)
    }
    
    // var dictionaryRepresentation:
}
