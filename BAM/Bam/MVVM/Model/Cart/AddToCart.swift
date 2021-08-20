//
//  AddToCart.swift
//  Bam
//
//  Created by ADS N URL on 22/04/21.
//

import Foundation


struct AddtoCartModel : Codable {
    let status : Bool?
    let message : String?
    let data : AddtoCartModelData?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(AddtoCartModelData.self, forKey: .data)
    }
}


struct AddtoCartModelData : Codable {
    let id : Int?
    let product_id : String?
    let quantity : String?
    let token : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, status
        case product_id, quantity, token, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
