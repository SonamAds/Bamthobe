//
//  Profile.swift
//  Bam
//
//  Created by ADS N URL on 15/04/21.
//

import Foundation


struct ProfileModel : Codable {
    let status : Bool?
    let message : String?
    let data : ProfileDataModel?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ProfileDataModel.self, forKey: .data)
    }

}


struct ProfileDataModel : Codable {
    let id : Int?
    let name : String?
    let email : String?
    let mobile : String?
    let gender : String?
    let image : String?
    let email_verified_at : String?
    let password_show : String?
    let type : String?
    let role_id : String?
    let token : String?
    let otp : String?
    let verified : Int?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {
        case id, status
        case name, email, mobile, gender, image, email_verified_at, password_show, type, role_id, token, otp, verified, created_at, updated_at
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        password_show = try values.decodeIfPresent(String.self, forKey: .password_show)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        role_id = try values.decodeIfPresent(String.self, forKey: .role_id)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        verified = try values.decodeIfPresent(Int.self, forKey: .verified)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
