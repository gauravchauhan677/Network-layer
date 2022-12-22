//
//  GalleryAPI.swift
//  NetworkLayer
//
//  Created by Gaurav Chauhan on 15/12/22.
//

import Foundation

struct GalleryAPI: APIHandler {
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().gallary
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> GalleryModel {
        return try defaultParseResponse(data: data,response: response)
    }
}

