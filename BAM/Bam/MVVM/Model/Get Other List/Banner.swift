//
//  Banner.swift
//  Bam
//
//  Created by ADS N URL on 21/04/21.
//

import Foundation


struct BannerModel : Codable {
    let status : Bool?
    let message : String?
    let data : [BannerDataModel]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([BannerDataModel].self, forKey: .data)
    }

}


struct BannerDataModel : Codable {
    let id : Int?
    let category_name : String?
    let type : String?
    let image : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, status
        case category_name, type, image, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
