//
//  MarsRoverController.swift
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import Foundation

class MarsRoverController {
    
    let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=ncS22avI8uLhNGuabNs82L79amxcTAO4mTn9Lv7f")!
    
    func fetchPhotos(completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: baseURL)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with data task: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error getting data")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do  {
                let marsRoverPhotoManifest = try decoder.decode(MarsRoverPhotos.self, from: data)
                
                for photo in marsRoverPhotoManifest.photos {
                    print(photo.identifier)
                    print(photo.earthDate)
                    print(photo.sol)
                    print(photo.imgSrc)
                    print(photo.rover.identifier)
                    print(photo.camera.fullName)
                }
                
                print(marsRoverPhotoManifest.photos.count)
                
            } catch {
                print("Error parsing data: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
        
    }
    
}
