//
//  Data+ToString.swift
//  Timeline
//
//  Created by Mauricio Caro Caro on 22-02-25.
//

import Foundation

extension Data {
    // Función para convertir el contenido de Data en un String
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
