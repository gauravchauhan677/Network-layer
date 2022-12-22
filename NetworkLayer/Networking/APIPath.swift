//
//  APIPath.swift
//  NetworkLayer
//
//  Created by Gaurav Chauhan on 15/12/22.
//

import Foundation

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var gallary: String { return "\(baseURL)/search/photos"}

}
