//
//  LoyaltyModel.swift
//  Bam
//
//  Created by ADS N URL on 07/05/21.
//

import Foundation


struct LoyaltyModel : Codable {
    let status : Bool?
    let message : String?
    let data : LoyaltyModelData?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(LoyaltyModelData.self, forKey: .data)
    }

}

struct LoyaltyModelData : Codable {
    let total_points : Int?
    let list : [LoyaltyModelList]?

    enum CodingKeys: String, CodingKey {

        case total_points = "total_points"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total_points = try values.decodeIfPresent(Int.self, forKey: .total_points)
        list = try values.decodeIfPresent([LoyaltyModelList].self, forKey: .list)
    }

}


struct LoyaltyModelList : Codable {
    let id : Int?
    let points : String?
    let token : String?
    let status : Int?
    let orderid : String?
    let suborderid : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, status
        case points, token, orderid, suborderid, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        points = try values.decodeIfPresent(String.self, forKey: .points)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        orderid = try values.decodeIfPresent(String.self, forKey: .orderid)
        suborderid = try values.decodeIfPresent(String.self, forKey: .suborderid)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
