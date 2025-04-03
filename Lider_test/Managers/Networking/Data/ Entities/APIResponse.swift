//
//  APIResponse.swift
//  Trip
//
//  Created by Mauricio Caro on 19-12-23.
//

import Foundation

public struct APIResponse<C: Codable> {
    public let statusCode: Int
    public let value: C?
    public let rawValue: Data?
    let headers: [AnyHashable: Any]?
    
    public init(statusCode: Int, value: C? = nil, rawValue: Data? = nil, headers: [AnyHashable: Any]? = nil) {
        self.statusCode = statusCode
        self.value = value
        self.rawValue = rawValue
        self.headers = headers
    }
}
