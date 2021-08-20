//
//  CustomizeCart.swift
//  Bam
//
//  Created by ADS N URL on 05/05/21.
//

import Foundation


struct CustomizeCart : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let price : Int?
    let image : String?
    let quantity : Int?
    let type : String?
    let view_more : ViewMoreCustomize?

    enum CodingKeys: String, CodingKey {

        case id, price, quantity
        case title, description, image, type
        case view_more
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        view_more = try values.decodeIfPresent(ViewMoreCustomize.self, forKey: .view_more)
    }

}


struct ViewMoreCustomize : Codable {
    let fabric : String?
    let color_code : String?
    let collar : String?
    let cuffs : String?
    let pocket : String?
    let placket : String?
    let button : String?
    let Customization_charge : Int?
    let visiting_charge : String?
    let advanced_payment : String?
    let remaining : String?

    enum CodingKeys: String, CodingKey {

        case fabric, collar, placket, button, Customization_charge, visiting_charge, advanced_payment, remaining, cuffs, pocket
        case color_code
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fabric = try values.decodeIfPresent(String.self, forKey: .fabric)
        color_code = try values.decodeIfPresent(String.self, forKey: .color_code)
        collar = try values.decodeIfPresent(String.self, forKey: .collar)
        cuffs = try values.decodeIfPresent(String.self, forKey: .cuffs)
        pocket = try values.decodeIfPresent(String.self, forKey: .pocket)
        placket = try values.decodeIfPresent(String.self, forKey: .placket)
        button = try values.decodeIfPresent(String.self, forKey: .button)
        Customization_charge = try values.decodeIfPresent(Int.self, forKey: .Customization_charge)
        visiting_charge = try values.decodeIfPresent(String.self, forKey: .visiting_charge)
        advanced_payment = try values.decodeIfPresent(String.self, forKey: .advanced_payment)
        remaining = try values.decodeIfPresent(String.self, forKey: .remaining)
    }

}
