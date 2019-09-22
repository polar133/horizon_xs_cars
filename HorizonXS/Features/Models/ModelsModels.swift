//
//  ModelsModels.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

typealias Model = Models.ViewModel.Model

enum Models {
    // MARK: Use cases
    struct Request {
        var name: String
    }

    struct Response {
        var hasMoreElements: Bool
        var models: [CarModel]
    }

    struct ViewModel {
        var hasMoreElements: Bool
        var models: [Model]
        //swiftlint:disable nesting
        struct Model {
            let name: String
            let fontColor: AssetsColor
            let backgroundColor: AssetsColor
        }
    }
}
