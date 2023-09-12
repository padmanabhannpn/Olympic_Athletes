//
//  AthletesDetailsViewModel.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
import UIKit

class AthletesDetailsViewModel: NSObject {
    override init() {
        super.init()
    }
    func getAthletesDetails(url:String, result: @escaping(Result<AthletesDetailsModel?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    func getAthletesResult(url:String, result: @escaping(Result<[AthletesResult]?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
}
