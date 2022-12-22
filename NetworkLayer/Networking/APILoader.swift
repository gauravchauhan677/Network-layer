//
//  APILoader.swift
//  NetworkLayer
//
//  Created by Gaurav Chauhan on 15/12/22.
//

import Foundation

//class APILoader<T: APIHandler> {
//    let apiReqeust: T
//    let urlSession: URLSession
//
//    init(apiReqeust: T, urlSession: URLSession = .shared) {
//        self.apiReqeust = apiReqeust
//        self.urlSession = urlSession
//    }
//
//    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, Error) -> ()) {
//        if let urlRequest = apiReqeust.makeRequest(from: requestData) {
//            urlSession.dataTask(with: urlRequest) { data, response, error in
//                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
//                    return completionHandler(nil, error)
//                }
//                do {
//                    let parsedResponse = try self.apiReqeust.parseResponse(data: data, response: httpResponse)
//                    completionHandler(parsedResponse, nil)
//
//                } catch {
//                    completionHandler(nil, error)
//                }
//            }.resume()
//        }
//    }
//
//}

struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? "Unknown Error")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                         completionHandler(parsedResponse, nil)
                    } catch {
                         completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                    }
                    
                }
                
               
            }.resume()
        }
    }
}
