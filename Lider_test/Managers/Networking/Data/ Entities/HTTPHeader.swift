//
//  HTTPHeader.swift
//  Trip
//
//  Created by Mauricio Caro on 18-12-23.
//

import Foundation

public struct HTTPHeader {
    public let key: String
    public let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
