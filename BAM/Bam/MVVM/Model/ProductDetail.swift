//
//  ProductDetail.swift
//  Bam
//
//  Created by ADS N URL on 22/04/21.
//

import Foundation
import ImageSlideshow


struct ProductDetailModel : Codable {
    let status : Bool?
    let message : String?
    let data : ProductDetailModelData?

    enum CodingKeys: String, CodingKey {

        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ProductDetailModelData.self, forKey: .data)
    }

}


struct ProductDetailModelData : Codable {
    let id : Int?
    let category_id : Int?
    let sub_category_id : Int?
    let title : String?
    let description : String?
    let image : [String]?
    let cost : String?
    let featured : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    let category_name : String?
    let review : [ProductDetailReview]?
    let like : [ProductDetailLike]?
    let is_measurement_required : String?
    
    
    enum CodingKeys: String, CodingKey {

        case id, status, category_id
        case sub_category_id, title, description, cost, featured, created_at, updated_at, category_name, is_measurement_required
        case image
        case review
        case like
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        sub_category_id = try values.decodeIfPresent(Int.self, forKey: .sub_category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent([String].self, forKey: .image)
        cost = try values.decodeIfPresent(String.self, forKey: .cost)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        review = try values.decodeIfPresent([ProductDetailReview].self, forKey: .review)
        like = try values.decodeIfPresent([ProductDetailLike].self, forKey: .like)
        is_measurement_required = try values.decodeIfPresent(String.self, forKey: .is_measurement_required)

    }
 
}


struct ProductDetailLike : Codable {
    let id : Int?
    let category_id : Int?
    let sub_category_id : Int?
    let title : String?
    let description : String?
    let image : [String]?
    let cost : String?
    let featured : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id, category_id, status
        case sub_category_id, title, description, cost, featured, created_at, updated_at
        case image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        sub_category_id = try values.decodeIfPresent(Int.self, forKey: .sub_category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent([String].self, forKey: .image)
        cost = try values.decodeIfPresent(String.self, forKey: .cost)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}


struct ProductDetailReview : Codable {
    let id : Int?
    let user_token : String?
    let product_id : Int?
    let comments : String?
    let star : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    let name : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id, product_id, status
        case user_token, comments, star, created_at, updated_at, name, image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_token = try values.decodeIfPresent(String.self, forKey: .user_token)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
        comments = try values.decodeIfPresent(String.self, forKey: .comments)
        star = try values.decodeIfPresent(String.self, forKey: .star)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
