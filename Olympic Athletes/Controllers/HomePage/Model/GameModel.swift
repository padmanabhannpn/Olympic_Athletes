//
//  GameModel.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
class GameModel : Codable {
    let game_id : Int?
    let city : String?
    let year : Int?

    enum CodingKeys: String, CodingKey {

        case game_id = "game_id"
        case city = "city"
        case year = "year"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        game_id = try values.decodeIfPresent(Int.self, forKey: .game_id)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
    }

}
