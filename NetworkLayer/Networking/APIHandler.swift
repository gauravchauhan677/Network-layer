//
//  APIHandler.swift
//  NetworkLayer
//
//  Created by Gaurav Chauhan on 15/12/22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data : RequestDataType) -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler 
