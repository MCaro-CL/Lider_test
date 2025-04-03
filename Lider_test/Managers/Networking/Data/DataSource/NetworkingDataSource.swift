//
//  NetworkingDataSource.swift
//  Trip
//
//  Created by Mauricio Caro on 18-12-23.
//

import Foundation

public protocol NetworkingDataSource {
    func dowload(
        url:URL,
        method:String,
        headers: [[String: String]] ,
        body: Data?
    ) async throws -> (Data,URLResponse)
}
