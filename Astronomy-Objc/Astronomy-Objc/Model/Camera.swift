//
//  Camera.swift
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation


class Camera: NSObject {

    let name: String
    let fullName: String

    init(name: String, fullName: String) {
        self.name = name
        self.fullName = fullName
    }
}
