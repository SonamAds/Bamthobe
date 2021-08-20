//
//  NormalCart.swift
//  Bam
//
//  Created by ADS N URL on 23/04/21.
//

import Foundation


struct NormalCartData : Codable {
    let id : Int?
    let product_id : String?
    let quantity : String?
    let token : String?
    let coupon : String?
    let coupon_price : Int?
    let status : String?
    let created_at : String?
    let points_price : Int?
    let updated_at : String?
    let title : String?
    let image : String?
    let description : String?
    let cost : String?
    let total_cost : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id, points_price
        case product_id, quantity, token, created_at, updated_at, title, image, description, cost, type, total_cost, status, coupon, coupon_price
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        cost = try values.decodeIfPresent(String.self, forKey: .cost)
        total_cost = try values.decodeIfPresent(String.self, forKey: .total_cost)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        coupon = try values.decodeIfPresent(String.self, forKey: .coupon)
        coupon_price = try values.decodeIfPresent(Int.self, forKey: .coupon_price)
        points_price = try values.decodeIfPresent(Int.self, forKey: .points_price)
        
    }

}
