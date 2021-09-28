//
//  Cart.swift
//  Bam
//
//  Created by ADS N URL on 22/04/21.
//

import Foundation


struct CartModel : Codable {
    let status : Bool?
    let message : String?
    let data : CartModelData?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(CartModelData.self, forKey: .data)
    }
}


struct CartModelData : Codable {
    let normal : [NormalCartData]?
    let gift_cart : [GiftCartModelData]?
    let customize : [CustomizeCart]?
    let thobe_total : Int?
    let accessories_total : Int?
    let gift_card_amount : Int?
    let delivery_charge : Int?
    let coupon_applied : Int?
    let grand_total : String?
    let loyality_point : Int?
    let points_apply : Int?
    let total_quantity : Int?
    let advance_payment : String?
    let remaining : String?
    let payable_amount : String?
    
    enum CodingKeys: String, CodingKey {

        case normal
        case gift_cart
        case customize
        case payable_amount, remaining, advance_payment, grand_total
        case thobe_total, accessories_total, gift_card_amount, delivery_charge, coupon_applied, points_apply, loyality_point, total_quantity
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        normal = try values.decodeIfPresent([NormalCartData].self, forKey: .normal)
        gift_cart = try values.decodeIfPresent([GiftCartModelData].self, forKey: .gift_cart)
        customize = try values.decodeIfPresent([CustomizeCart].self, forKey: .customize)
        thobe_total = try values.decodeIfPresent(Int.self, forKey: .thobe_total)
        accessories_total = try values.decodeIfPresent(Int.self, forKey: .accessories_total)
        gift_card_amount = try values.decodeIfPresent(Int.self, forKey: .gift_card_amount)
        delivery_charge = try values.decodeIfPresent(Int.self, forKey: .delivery_charge)
        coupon_applied = try values.decodeIfPresent(Int.self, forKey: .coupon_applied)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
        loyality_point = try values.decodeIfPresent(Int.self, forKey: .loyality_point)
        points_apply = try values.decodeIfPresent(Int.self, forKey: .points_apply)
        total_quantity = try values.decodeIfPresent(Int.self, forKey: .total_quantity)
        
        advance_payment = try values.decodeIfPresent(String.self, forKey: .advance_payment)
        remaining = try values.decodeIfPresent(String.self, forKey: .remaining)
        payable_amount = try values.decodeIfPresent(String.self, forKey: .payable_amount)

    }

}



//struct CartModelData : Codable {
//    let id : Int?
//    let product_id : String?
//    let quantity : String?
//    let token : String?
//    let status : Int?
//    let created_at : String?
//    let updated_at : String?
//    let title : String?
//    let image : String?
//    let description : String?
//    let cost : String?
//    let total_cost : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id, status, total_cost
//        case product_id, quantity, token, created_at, updated_at, title, image, description, cost
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
//        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
//        token = try values.decodeIfPresent(String.self, forKey: .token)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        cost = try values.decodeIfPresent(String.self, forKey: .cost)
//        total_cost = try values.decodeIfPresent(Int.self, forKey: .total_cost)
//    }
//
//}
