//
//  MarsRoverPhoto.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import Foundation

class MarsRoverPhoto: NSObject, Decodable {
    var identifier: Int
    var sol: Int
    var camera: Camera
    var imgSrc: String
    var earthDate: String
    var rover: Rover
    
    enum PhotoCodingKeys: String, CodingKey {
        case photos
    }
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case sol
        case camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    enum CameraCodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
    
    enum RoverCodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case cameras
    }
    
    init(identifier: Int, sol: Int, camera: Camera, imgSrc: String, earthDate: String, rover: Rover) {
        self.identifier = identifier
        self.sol = sol
        self.camera = camera
        self.imgSrc = imgSrc
        self.earthDate = earthDate
        self.rover = rover
    }
    
    public required init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: PhotoCodingKeys.self)
        var photoContainer = try topContainer.nestedUnkeyedContainer(forKey: .photos)
        let container = try photoContainer.nestedContainer(keyedBy: CodingKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        sol = try container.decode(Int.self, forKey: .sol)
        
        let cameraContainer = try container.nestedContainer(keyedBy: CameraCodingKeys.self, forKey: .camera)
        let cameraID = try cameraContainer.decode(Int32.self, forKey: .identifier)
        let cameraName = try cameraContainer.decode(String.self, forKey: .name)
        let roverID = try cameraContainer.decode(Int32.self, forKey: .roverID)
        let fullName = try cameraContainer.decode(String.self, forKey: .fullName)
        let camera = Camera(identifier: cameraID, name: cameraName, roverIdentifier: roverID, fullName: fullName)
        self.camera = camera
        
        imgSrc = try container.decode(String.self, forKey: .imgSrc)
        earthDate = try container.decode(String.self, forKey: .earthDate)
        
        let roverContainer = try container.nestedContainer(keyedBy: RoverCodingKeys.self, forKey: .rover)
        // for roverID use same roverID as declared in camera container above
        let roverName = try roverContainer.decode(String.self, forKey: .name)
        let landingDate = try roverContainer.decode(String.self, forKey: .landingDate)
        let launchDate = try roverContainer.decode(String.self, forKey: .launchDate)
        let status = try roverContainer.decode(String.self, forKey: .status)
        let maxSol = try roverContainer.decode(Int32.self, forKey: .maxSol)
        let maxDate = try roverContainer.decode(String.self, forKey: .maxDate)
        let totalPhotos = try roverContainer.decode(Int32.self, forKey: .totalPhotos)
        // TODO: cameras
        let rover = Rover(identifier: roverID, name: roverName, landingDate: landingDate, launchDate: launchDate, status: status, maxSol: maxSol, maxDate: maxDate, totalPhotos: totalPhotos)
        self.rover = rover
        
        super.init()
    }
    
//    required init(coder decoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    // Not sure if this will be necessary yet but saving just in case.
    
    // @objc public class func create(from url: URL) -> MarsRoverPhoto {
    //        let decoder = JSONDecoder()
    //        let marsRoverPhoto = try! decoder.decode(MarsRoverPhoto.self, from: try! Data(contentsOf: url))
    //        return marsRoverPhoto
    //    }
    
}


