//
//  String+URLEncoded.swift
//  Socials
//
//  Created by Mauricio Caro Caro on 22-03-25.
//

import Foundation

extension String {
    func URLEncoded() -> String {
        var allowedCharacters = CharacterSet.urlQueryAllowed
        allowedCharacters.remove(charactersIn: ":/?#[]@!$&'()*+,;=")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? self
    }
}
