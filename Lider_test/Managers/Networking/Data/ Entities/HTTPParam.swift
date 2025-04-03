//
//  HTTPParam.swift
//  NetworkingManager
//
//  Created by Mauricio Caro Caro on 10-02-25.
//

import Foundation

public struct HTTPParam {
    public let key: String
    public let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
