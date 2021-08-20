//
//  SuccessModel.swift
//  Bam
//
//  Created by ADS N URL on 15/04/21.
//

import Foundation

struct SuccessModel : Codable {
    let status : Bool?
    let message : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status
        case message, data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
