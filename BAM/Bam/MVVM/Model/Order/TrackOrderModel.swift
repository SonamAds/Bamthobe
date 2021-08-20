//
//  TrackOrderModel.swift
//  Bam
//
//  Created by ADS N URL on 29/04/21.
//

import Foundation


struct TrackOrderModel : Codable {
    let status : Bool?
    let message : String?
    let data : TrackOrderModelData?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(TrackOrderModelData.self, forKey: .data)
    }

}

struct TrackOrderModelData : Codable {
    let id : Int?
    let delivery_status : Int?
    let image : String?
    let title : String?
    let description : String?
    let price : String?
    let quantity : Int?
    let order_id : String?
    let placed_on : String?
    let delivery_time : String?
    let address : String?
    let total : String?
    let delivery_charge : Int?
    let coupon_applied : Int?
    let coupon : Int?
    let visiting_charge : String?
    let advanced_payment : String?
    let remaining : String?
    let status_message : [String]?

    enum CodingKeys: String, CodingKey {

        case id, delivery_status, coupon, coupon_applied
        case image, title, description, price, quantity, order_id, placed_on, delivery_time, address, total, delivery_charge, visiting_charge, advanced_payment, remaining
        case status_message
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        delivery_status = try values.decodeIfPresent(Int.self, forKey: .delivery_status)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
        placed_on = try values.decodeIfPresent(String.self, forKey: .placed_on)
        delivery_time = try values.decodeIfPresent(String.self, forKey: .delivery_time)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        delivery_charge = try values.decodeIfPresent(Int.self, forKey: .delivery_charge)
        coupon_applied = try values.decodeIfPresent(Int.self, forKey: .coupon_applied)
        coupon = try values.decodeIfPresent(Int.self, forKey: .coupon)
        visiting_charge = try values.decodeIfPresent(String.self, forKey: .visiting_charge)
        advanced_payment = try values.decodeIfPresent(String.self, forKey: .advanced_payment)
        remaining = try values.decodeIfPresent(String.self, forKey: .remaining)
        status_message = try values.decodeIfPresent([String].self, forKey: .status_message)
    }

}


