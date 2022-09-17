//
//  Products.swift
//  ProductsInfoApp
//
//  Created by Sreedhar L on 17/09/22.
//

import Foundation

struct ProductInfo: Codable {
    var id: Int?
    var title: String?
    var price: Float?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?
    
    enum CodingKeys: String, CodingKey {
        case id,title,price,description,category,image,rating
    }
}

struct Rating: Codable {
    var rate: Float?
    var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case rate = "rate"
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        rate = try? container.decodeIfPresent(Float.self, forKey: .rate)
        count = try? container.decodeIfPresent(Int.self, forKey: .count)
     }
}
