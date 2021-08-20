//
//  GiftDescription.swift
//  Bam
//
//  Created by ADS N URL on 23/04/21.
//

import Foundation


struct GiftDescriptionModel : Codable {
    let status : Bool?
    let message : String?
    let data : GiftModelData?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(GiftModelData.self, forKey: .data)
    }

}
