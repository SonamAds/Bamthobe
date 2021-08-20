//
//  PocketModel.swift
//  Bam
//
//  Created by ADS N URL on 03/05/21.
//

import Foundation


struct PocketModel : Codable {
    let status : Bool?
    let message : String?
    let data : [PocketModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([PocketModelData].self, forKey: .data)
    }

}


struct PocketModelData : Codable {
    let id : Int?
    let thobe_style_id : Int?
    let pocket : String?
    let image : String?
    let price : String?
    let type : String?
    let description : String?
    let visible_image : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, status, thobe_style_id, price
        case pocket, image, type, description, created_at, updated_at, visible_image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        thobe_style_id = try values.decodeIfPresent(Int.self, forKey: .thobe_style_id)
        pocket = try values.decodeIfPresent(String.self, forKey: .pocket)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        visible_image = try values.decodeIfPresent(String.self, forKey: .visible_image)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
