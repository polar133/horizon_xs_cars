//
//  ManufacturersEntity.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

struct ManufacturersEntity: Decodable, Equatable {
    let page: Int?
    let pageSize: Int?
    let totalPageCount: Int?
    let brands: [Brand]

    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case brands = "wkda"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        pageSize = try values.decode(Int.self, forKey: .pageSize)
        totalPageCount = try values.decode(Int.self, forKey: .totalPageCount)
        let list = try values.decode([String: String].self, forKey: .brands).sorted { $0.key < $1.key }
        brands = list.compactMap { return Brand(id: $0.key, name: $0.value) }
    }
}

struct Brand: Decodable, Hashable, Equatable {
    let id: String
    let name: String
}
