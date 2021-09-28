//
//  Slider.swift
//  Bam
//
//  Created by ADS N URL on 15/04/21.
//

import Foundation

struct SliderModel : Codable {
    let status : Bool?
    let message : String?
    let data : [SliderModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([SliderModelData].self, forKey: .data)
    }

}


struct SliderModelData : Codable {
    let id : Int?
    let main_title : String?
    let sub_title : String?
    let short_title : String?
    let image : String?
    let mobile_image : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {
        case id
        case main_title, sub_title, short_title, image, created_at, updated_at, mobile_image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main_title = try values.decodeIfPresent(String.self, forKey: .main_title)
        sub_title = try values.decodeIfPresent(String.self, forKey: .sub_title)
        short_title = try values.decodeIfPresent(String.self, forKey: .short_title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        mobile_image = try values.decodeIfPresent(String.self, forKey: .mobile_image)
    }

}
