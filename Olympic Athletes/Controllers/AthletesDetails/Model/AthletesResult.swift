//
//  AthletesResult.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation
class AthletesResult : Codable {
    let city : String?
    let year : Int?
    let gold : Int?
    let silver : Int?
    let bronze : Int?

    enum CodingKeys: String, CodingKey {

        case city = "city"
        case year = "year"
        case gold = "gold"
        case silver = "silver"
        case bronze = "bronze"
    }

   required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        gold = try values.decodeIfPresent(Int.self, forKey: .gold)
        silver = try values.decodeIfPresent(Int.self, forKey: .silver)
        bronze = try values.decodeIfPresent(Int.self, forKey: .bronze)
    }

}
