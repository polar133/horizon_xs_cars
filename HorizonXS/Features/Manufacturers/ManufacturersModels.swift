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
    struct Response {
        var brands: Set<Brand>
    }

    struct ViewModel {
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
