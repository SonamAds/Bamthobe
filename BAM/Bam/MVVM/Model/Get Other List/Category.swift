//
//  Category.swift
//  Bam
//
//  Created by ADS N URL on 15/04/21.
//

import Foundation

struct CategoryModel : Codable {
    let status : Bool?
    let message : String?
    let data : [CategoryDataModel]?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([CategoryDataModel].self, forKey: .data)
    }

}

struct CategoryDataModel : Codable {
    let id : Int?
    let category_name : String?
    let type : String?
    let image : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    
    
    enum CodingKeys: String, CodingKey {

        case id, status
        case category_name, created_at, updated_at, image, type
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)

        
    }

}
