//
//  ImageDownloader.swift
//  Lider_test
//
//  Created by Mauricio Caro Caro on 03-04-25.
//

import Foundation
import UIKit

final class ImageDownloader {
    static let shared = ImageDownloader()
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadImage(from url: URL) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200..<300).contains(httpResponse.statusCode) {
            throw NSError(domain: "ImageDownloader",
                          code: httpResponse.statusCode,
                          userInfo: [NSLocalizedDescriptionKey: "HTTP error \(httpResponse.statusCode)"])
        }
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageDownloader",
                          code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "No se pudo convertir los datos en imagen"])
        }
        
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
        return image
    }
    
    func downloadImageSync(from url: URL) -> UIImage? {
            // Revisar la caché para evitar descargas innecesarias.
            if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                return cachedImage
            }
            
            // Intentar descargar los datos de forma síncrona.
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    print("No se pudo convertir los datos en imagen.")
                    return nil
                }
                
                // Almacenar la imagen en caché.
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                return image
            } catch {
                print("Error al descargar la imagen: \(error.localizedDescription)")
                return nil
            }
        }
}
