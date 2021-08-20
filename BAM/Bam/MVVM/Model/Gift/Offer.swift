//
//  Offer.swift
//  Bam
//
//  Created by ADS N URL on 28/04/21.
//

import Foundation

struct OfferModel : Codable {
    let status : Bool?
    let message : String?
    let data : [OfferModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([OfferModelData].self, forKey: .data)
    }

}

struct OfferModelData : Codable {
    let id : Int?
    let image : String?
    let price : String?
    let code : String?
    let description : String?
    let expiry_date : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, status
        case image, price, code, description, expiry_date, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
