//
//  BranchModel.swift
//  Bam
//
//  Created by ADS N URL on 04/05/21.
//

import Foundation

struct BranchModel : Codable {
    let status : Bool?
    let message : String?
    let data : [BranchModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([BranchModelData].self, forKey: .data)
    }

}


struct BranchModelData : Codable {
    let id : Int?
    let branch : String?
    let address : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id
        case branch, address, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        branch = try values.decodeIfPresent(String.self, forKey: .branch)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
