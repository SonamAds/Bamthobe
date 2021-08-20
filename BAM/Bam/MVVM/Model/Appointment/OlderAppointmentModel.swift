//
//  OlderAppointmentModel.swift
//  Bam
//
//  Created by ADS N URL on 04/05/21.
//

import Foundation

struct OlderAppointmentModel : Codable {
    let status : Bool?
    let message : String?
    let data : [OlderAppointmentModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([OlderAppointmentModelData].self, forKey: .data)
    }

}

           
struct OlderAppointmentModelData : Codable {
    let id : Int?
    let booking_id : String?
    let store_name : String?
    let date : String?
    let store_address : String?
    let type : String?
    let name : String?
    let mobile : String?
    let home_address : String?

    enum CodingKeys: String, CodingKey {

        case id
        case booking_id, store_name, date, store_address, type, name, mobile, home_address
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        store_address = try values.decodeIfPresent(String.self, forKey: .store_address)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        home_address = try values.decodeIfPresent(String.self, forKey: .home_address)
    }

}
