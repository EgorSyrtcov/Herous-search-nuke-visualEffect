//
//  Pokemon.swift
//  Temp
//
//  Created by Egor Syrtcov on 21/11/2019.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import ObjectMapper


struct Hero: Codable  {
    let name: String?
    let images: ImageHero
    let powerstats: Powerstats
}

extension Hero: ImmutableMappable {
    
    init(map: Map) throws {
        name = try map.value("name")
        images = try map.value("images")
        powerstats = try map.value("powerstats")
    }
    
    func mapping(map: Map) {
        name >>> map["name"]
        images >>> map["images"]
        powerstats >>> map["powerstats"]
    }
}

