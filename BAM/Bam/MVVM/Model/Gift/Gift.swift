//
//  Gift.swift
//  Bam
//
//  Created by ADS N URL on 23/04/21.
//

import Foundation

struct GiftModel : Codable {
    let status : Bool?
    let message : String?
    let data : [GiftModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([GiftModelData].self, forKey: .data)
    }

}


struct GiftModelData : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let price : String?
    let image : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, status
        case title, description, price, image, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
