//
//  DemoURL.swift
//  03Cassini
//
//  Created by Julio Franco on 6/26/16.
//  Copyright © 2016 Julio Franco. All rights reserved.
//

import Foundation

struct DemoURL {
    
    static let Stanford = "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png"
    
    static let NASA = [
        "Cassini": "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth": "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn": "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNames(imageName: String?) -> NSURL? {
        if let urlString = NASA[imageName ?? ""] {
            return NSURL(string: urlString)
        } else {
            return nil
        }
    }
}


