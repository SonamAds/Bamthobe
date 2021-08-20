//
//  NotificationModel.swift
//  Bam
//
//  Created by ADS N URL on 10/06/21.
//

import Foundation
struct NotificationModel : Codable {
    let status : String?
    let msg : String?
    let data : [NotificationData]?

    enum CodingKeys: String, CodingKey {

        case status, msg
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent([NotificationData].self, forKey: .data)
    }

}


struct NotificationData : Codable {
    let id : Int?
    let user_token : String?
    let txn_id : String?
    let title : String?
    let visiblity : Int?
    let notification : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_token = "user_token"
        case txn_id = "txn_id"
        case title = "title"
        case visiblity = "visiblity"
        case notification = "notification"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_token = try values.decodeIfPresent(String.self, forKey: .user_token)
        txn_id = try values.decodeIfPresent(String.self, forKey: .txn_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        visiblity = try values.decodeIfPresent(Int.self, forKey: .visiblity)
        notification = try values.decodeIfPresent(String.self, forKey: .notification)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
