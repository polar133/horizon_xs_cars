//
//  ManufacturersWorker.swift
//  HorizonXS
//
//  Created by Carlos Jimenez on 9/21/19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//
import Foundation

class ManufacturersWorker {

    private let urlSession = URLSession.shared

    func fetchManufacturers(page: Int = 0, callback: @escaping (Result<ManufacturersEntity>) -> Void) {

        let params = [
            "wa_key": HorizonAPI.SecretKey,
            "page": "\(page)",
            "pageSize": "15"
        ]

        guard var url = URLComponents(string: HorizonAPI.Manufacturer) else {
            callback(.failure(XSError.invalidURL))
            return
        }
        url.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        url.percentEncodedQuery = url.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let urlRequest = url.url else {
            callback(.failure(XSError.invalidURL))
            return
        }

        urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            let response = response as? HTTPURLResponse
            if let data = data, let response = response, (200..<299).contains(response.statusCode) {
                do {
                    let value = try JSONDecoder().decode(ManufacturersEntity.self, from: data)
                    callback(.success(value))
                } catch {
                    callback(.failure(XSError.responseSerialization))
                }
            } else {
                callback(.failure(XSError.from(response?.statusCode, error: error, content: data)))
            }
        }).resume()
    }
}
