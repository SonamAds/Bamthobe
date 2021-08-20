//
//  ThobeCartAdd.swift
//  Bam
//
//  Created by ADS N URL on 04/05/21.
//

import Foundation


struct Json4Swift_Base : Codable {
    let status : Bool?
    let message : String?
    let data : Data?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Data.self, forKey: .data)
    }

}


struct Data : Codable {
    let id : Int?
    let booking_id : String?
    let token : String?
    let fabric : Int?
    let collar : Int?
    let cuffs : Int?
    let pocket : Int?
    let placket : Int?
    let button : Int?
    let side_pocket : String?
    let side_pocket_2 : String?
    let measurement : String?
    let measurement_type : String?
    let name : String?
    let mobile : String?
    let date : String?
    let branch : Int?
    let status : Int?
    let older_status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, fabric, collar, cuffs, pocket, placket, button, branch, status, older_status
        case booking_id, token, side_pocket, side_pocket_2, measurement, measurement_type, name, mobile, date, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        fabric = try values.decodeIfPresent(Int.self, forKey: .fabric)
        collar = try values.decodeIfPresent(Int.self, forKey: .collar)
        cuffs = try values.decodeIfPresent(Int.self, forKey: .cuffs)
        pocket = try values.decodeIfPresent(Int.self, forKey: .pocket)
        placket = try values.decodeIfPresent(Int.self, forKey: .placket)
        button = try values.decodeIfPresent(Int.self, forKey: .button)
        side_pocket = try values.decodeIfPresent(String.self, forKey: .side_pocket)
        side_pocket_2 = try values.decodeIfPresent(String.self, forKey: .side_pocket_2)
        measurement = try values.decodeIfPresent(String.self, forKey: .measurement)
        measurement_type = try values.decodeIfPresent(String.self, forKey: .measurement_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        branch = try values.decodeIfPresent(Int.self, forKey: .branch)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        older_status = try values.decodeIfPresent(Int.self, forKey: .older_status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
