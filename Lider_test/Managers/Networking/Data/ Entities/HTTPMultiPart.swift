//
//  HTTPMultiPart.swift
//  Socials
//
//  Created by Mauricio Caro Caro on 22-03-25.
//

import Foundation

struct HTTPMultiPart {
    var boundary: String
    private var body = Data()
    
    init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
    }
    
    var contentType: String {
        "multipart/form-data; boundary=\(boundary)"
    }
    
    var data: Data {
        var finalData = body
        if let closing = "--\(boundary)--\r\n".data(using: .utf8) {
            finalData.append(closing)
        }
        return finalData
    }

    mutating func addField(name: String, value: String) {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
        body.append("\(value)\r\n")
    }
    
    mutating func addFileField(name: String, filename: String, mimeType: String, fileData: Data) {
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.append("\r\n")
    }
}

private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
