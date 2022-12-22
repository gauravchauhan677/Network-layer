//
//  ResponseHandler+Extension.swift
//  NetworkLayer
//
//  Created by Gaurav Chauhan on 15/12/22.
//

import Foundation

struct ServiceError : Error, Codable {
    
    let httpStatus: Int
    let message: String
}

extension RequestHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse)throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
    }
}
