//
//  Service.swift
//  Temp
//
//  Created by Egor Syrtcov on 11/21/19.
//  Copyright © 2019 Egor Syrtcov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class Service {
    
    static let shared = Service()
    let URL = "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json"
    
    func fetchData(complition: @escaping ([Hero]) -> ()) {
        
        var herousArray = [Hero]()
        
        Alamofire.request(URL).responseArray { (response: DataResponse<[Hero]>) in
            let herous = response.result.value
        
                if let newHerous = herous  {
                    for hero in newHerous {
                        herousArray.append(hero)
                        
                        DispatchQueue.main.async {
                            complition(herousArray)
                }
            }
        }
      }
   }
}
