//
//  ImagePokemon.swift
//  Temp
//
//  Created by Egor Syrtcov on 11/21/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import ObjectMapper

struct ImageHero: Codable  {
    let image: String
}

extension ImageHero: ImmutableMappable {
    
    init(map: Map) throws {
        image = try map.value("sm")
    }
    
    func mapping(map: Map) {
        image >>> map["sm"]
    }
}
