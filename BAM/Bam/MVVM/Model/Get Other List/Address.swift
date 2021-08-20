//
//  Address.swift
//  Bam
//
//  Created by ADS N URL on 15/04/21.
//

import Foundation
struct AddressModel : Codable {
    let status : Bool?
    let message : String?
    let data : [AddressDataModel]?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([AddressDataModel].self, forKey: .data)
    }

}


struct AddressDataModel : Codable {
    let id : Int?
    let user_id : String?
    let home_type : String?
    let name : String?
    let address : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    let lat : String?
    let lng: String?
    
    enum CodingKeys: String, CodingKey {
        case id, status
        case user_id, home_type, name, address, created_at, updated_at, lat, lng
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        home_type = try values.decodeIfPresent(String.self, forKey: .home_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)

        lng = try values.decodeIfPresent(String.self, forKey: .lng)

    }

}
