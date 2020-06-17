//
//  NSURL+UsingHTTPS.swift
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/16/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

@objc extension NSURL {
    var usingHTTPS: NSURL? {
        guard var components = URLComponents(url: self as URL, resolvingAgainstBaseURL: true) else { return nil }
        components.scheme = "https"
        guard let url = components.url else { return nil }
        return url as NSURL
    }
}
