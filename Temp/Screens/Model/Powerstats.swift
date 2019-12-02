//
//  Powerstats.swift
//  Temp
//
//  Created by Egor Syrtcov on 11/25/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import ObjectMapper

struct Powerstats: Codable  {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let power: Int
}

extension Powerstats: ImmutableMappable {
    
    init(map: Map) throws {
        intelligence = try map.value("intelligence")
        strength = try map.value("strength")
        speed = try map.value("speed")
        power = try map.value("power")
    }
    
    func mapping(map: Map) {
        intelligence >>> map["intelligence"]
        strength >>> map["strength"]
        speed >>> map["speed"]
        power >>> map["power"]
    }
}
