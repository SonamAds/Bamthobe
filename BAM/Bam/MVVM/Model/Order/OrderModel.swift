//
//  OrderModel.swift
//  Bam
//
//  Created by ADS N URL on 28/04/21.
//

import Foundation

struct OrderModel : Codable {
    let status : Bool?
    let message : String?
    let data : [OrderModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([OrderModelData].self, forKey: .data)
    }

}


struct OrderModelData : Codable {
    let order_id : Int?
    let sub_order_id : String?
    let title : String?
    let type : String?
    let description : String?
    let price : String?
    let quantity : Int?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case order_id
        case title, description, price, quantity, image, sub_order_id, type
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        sub_order_id = try values.decodeIfPresent(String.self, forKey: .sub_order_id)
    }

}
