//
//  NetProtocol.swift
//  NetworkProtocol
//
//  Created by Mauricio Caro Caro on 28-01-25.
//

import Foundation

public protocol NetProtocol{
    func download<C: Codable, T: Codable>(_ request: APIRequest<C, T>) async throws -> Result<APIResponse<T>, HTTPError>
}



