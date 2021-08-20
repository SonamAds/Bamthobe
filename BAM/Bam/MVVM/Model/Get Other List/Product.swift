//
//  SubCategory.swift
//  Bam
//
//  Created by ADS N URL on 21/04/21.
//

import Foundation

struct ProductModel : Codable {
    let status : Bool?
    let message : String?
    let data : [ProductModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([ProductModelData].self, forKey: .data)
    }
}


struct ProductModelData : Codable {
    let id : Int?
    let category_id : Int?
    let sub_category_id : String?
    let title : String?
    let description : String?
    let image : String?
    let cost : String?
    let featured : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, category_id, status
        case sub_category_id, title, description, image, cost, featured, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        sub_category_id = try values.decodeIfPresent(String.self, forKey: .sub_category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        cost = try values.decodeIfPresent(String.self, forKey: .cost)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
