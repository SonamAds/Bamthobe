//
//  GiftCart.swift
//  Bam
//
//  Created by ADS N URL on 23/04/21.
//

import Foundation


struct GiftCartModelData : Codable {
    let id : Int?
    let token : String?
    let gift_id : Int?
    let date : String?
    let time : String?
    let g_to : String?
    let message : String?
    let g_from : String?
    let g_points_price : String?
    let receiver_name : String?
    let mobile : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    let title : String?
    let image : String?
    let description : String?
    let price : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id, status, gift_id
        case token, image, description, date, time, g_to, message, g_from, receiver_name, mobile, created_at, updated_at, title, price, type, g_points_price
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        gift_id = try values.decodeIfPresent(Int.self, forKey: .gift_id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        g_to = try values.decodeIfPresent(String.self, forKey: .g_to)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        g_from = try values.decodeIfPresent(String.self, forKey: .g_from)
        receiver_name = try values.decodeIfPresent(String.self, forKey: .receiver_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        g_points_price = try values.decodeIfPresent(String.self, forKey: .g_points_price)
    }

}
