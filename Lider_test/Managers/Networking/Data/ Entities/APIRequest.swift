//
//  APIRequest.swift
//  Trip
//
//  Created by Mauricio Caro on 19-12-23.
//

import Foundation

public struct BodyEmpty: Codable {}

public struct APIRequest<B: Codable, R: Codable> {
    let baseUrl: String
    let params: [HTTPParam]
    let method: HTTPMethod
    let headers: [HTTPHeader]
    let body: B?
    let rawBody: Data?
    let responseType: R.Type
    
        // Inicializador principal (para solicitudes con cuerpo)
    public init(
        baseUrl: String,
        params:[HTTPParam] = [],
        method: HTTPMethod,
        headers: [HTTPHeader] = [],
        body: B? = nil,
        rawBody: Data? = nil,
        responseType: R.Type
    ) {
        self.baseUrl = baseUrl
        self.params = params
        self.method = method
        self.headers = headers
        self.body = body
        self.rawBody = rawBody
        self.responseType = responseType
    }
    
        // Inicializador alternativo (para solicitudes sin cuerpo)
    public init(baseUrl: String, params: [HTTPParam] = [], method: HTTPMethod, headers: [HTTPHeader] = [], rawBody: Data? = nil, responseType: R.Type) where B == BodyEmpty {
        self.baseUrl = baseUrl
        self.params = params
        self.method = method
        self.headers = headers
        self.body = nil
        self.rawBody = rawBody
        self.responseType = responseType
    }
}

