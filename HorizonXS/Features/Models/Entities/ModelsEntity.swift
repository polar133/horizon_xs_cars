//
//  ModelsEntity.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import Foundation

struct ModelsEntity: Decodable, Equatable {
    let page: Int?
    let pageSize: Int?
    let totalPageCount: Int?
    let models: [CarModel]

    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case models = "wkda"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        pageSize = try values.decode(Int.self, forKey: .pageSize)
        totalPageCount = try values.decode(Int.self, forKey: .totalPageCount)
        let list = try values.decode([String: String].self, forKey: .models).sorted { $0.key < $1.key }
        models = list.compactMap { return CarModel(id: $0.key, name: $0.value) }
    }
}

struct CarModel: Decodable, Hashable, Equatable {
    let id: String
    let name: String
}
