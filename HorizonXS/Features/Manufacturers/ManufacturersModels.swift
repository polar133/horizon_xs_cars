//
//  ManufacturersModels.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

typealias BrandViewModel = Manufacturers.ViewModel.Brand

enum Manufacturers {
    // MARK: Use cases
    struct Request {
        var id: String
        var name: String
    }

    struct Response {
        var hasMoreElements: Bool
        var brands: [Brand]
    }

    struct ViewModel {
        var hasMoreElements: Bool
        var brands: [Brand]
        //swiftlint:disable nesting
        struct Brand {
            let id: String
            let name: String
            let fontColor: AssetsColor
            let backgroundColor: AssetsColor
        }
    }
}
