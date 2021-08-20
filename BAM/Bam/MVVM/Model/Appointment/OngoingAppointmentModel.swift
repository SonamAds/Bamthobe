//
//  OngoingAppointmentModel.swift
//  Bam
//
//  Created by ADS N URL on 04/05/21.
//

import Foundation

struct OngoingAppointmentModel : Codable {
    let status : Bool?
    let message : String?
    let data : [OngoingAppointmentModelData]?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([OngoingAppointmentModelData].self, forKey: .data)
    }

}

           
struct OngoingAppointmentModelData : Codable {
    let id : Int?
    let booking_id : String?
    let date : String?
    let name : String?
    let mobile : String?
    let store_name : String?
    let store_address : String?
    let home_address : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case booking_id, date, name, mobile, store_name, store_address, home_address, type
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        store_address = try values.decodeIfPresent(String.self, forKey: .store_address)
        home_address = try values.decodeIfPresent(String.self, forKey: .home_address)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
