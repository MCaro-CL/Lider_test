//
//  createMultipart.swift
//  Socials
//
//  Created by Mauricio Caro Caro on 21-03-25.
//

import Foundation


func createMultipart(boundary: String, fileData: Data, fileName: String, fieldName: String = "source") -> Data {
        let mimeType = mimeType(for: fileName)
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"

        guard let boundaryData = boundaryPrefix.data(using: .utf8),
              let contentDisposition = "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8),
              let contentType = "Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8),
              let boundaryEnd = "\r\n--\(boundary)--\r\n".data(using: .utf8) else {
            return body
        }

        body.append(boundaryData)
        body.append(contentDisposition)
        body.append(contentType)
        body.append(fileData)
        body.append(boundaryEnd)

        return body
    }

    private func mimeType(for fileName: String) -> String {
        let ext = (fileName as NSString).pathExtension.lowercased()

        switch ext {
        case "jpg", "jpeg": return "image/jpeg"
        case "png": return "image/png"
        case "gif": return "image/gif"
        case "pdf": return "application/pdf"
        case "mov": return "video/quicktime"
        case "mp4": return "video/mp4"
        default: return "application/octet-stream"
        }
    }

