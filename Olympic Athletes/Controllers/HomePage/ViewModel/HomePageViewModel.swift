//
//  HomePageViewModel.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation

class HomePageViewModel: NSObject {
    override init() {
        super.init()
    }
    func getAthletes(url:String, result: @escaping(Result<[GameModel]?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    func getAthletesUser(url:String, result: @escaping(Result<[AthletesUserModel]?,ApiError>) -> Void){
        ApiManager.shared.fetch(baseUrl: url, methodType: .get, contentType: .applicationJson, param: "", completion: result)
    }
    
    
}
