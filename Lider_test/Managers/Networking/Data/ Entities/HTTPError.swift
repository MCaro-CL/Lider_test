    //
    //  HTTPError.swift
    //  Trip
    //
    //  Created by Mauricio Caro on 19-12-23.
    //

    import Foundation

    public enum HTTPError: Error {
        case invalidURL(String)
        case invalidParams(String)
        case invalidHeaderFields
        case invalidBody(Data)
        case invalidDecoder(Data?)
        case invalidResponse(String?)
        case informational(Int)
        case redirection(Int)
        case clientError(Int)
        case serverError(Int)
        case custom(String)
    }

    extension HTTPError {
        public var userMessage: String {
            switch self {
            case .invalidURL:
                return "La dirección web no es válida."
            case .invalidParams:
                return "Los datos enviados no son correctos."
            case .invalidHeaderFields:
                return "Hubo un error al preparar la solicitud."
            case .invalidBody:
                return "No se pudo procesar la información enviada."
            case .invalidDecoder:
                return "No se pudo leer la respuesta del servidor."
            case .invalidResponse:
                return "La respuesta del servidor no es válida."
            case .informational:
                return "El servidor envió una respuesta informativa."
            case .redirection:
                return "La solicitud fue redirigida por el servidor."
            case .clientError:
                return "Ocurrió un error en la solicitud."
            case .serverError:
                return "El servidor encontró un problema al procesar la solicitud."
            case .custom(let message):
                return message
            }
        }

        public var debugDescription: String {
            switch self {
            case .invalidURL(let url):
                return "URL inválida: \(url)"
            case .invalidParams(let context):
                return "Parámetros inválidos: \(context)"
            case .invalidHeaderFields:
                return "Faltan o son incorrectos los encabezados HTTP."
            case .invalidBody(let data):
                return "Cuerpo de la solicitud inválido. Data: \(String(decoding: data, as: UTF8.self))"
            case .invalidDecoder(let data):
                    return "Fallo al decodificar respuesta. Raw data: \(String(decoding: data ?? Data(), as: UTF8.self))"
            case .invalidResponse(let message):
                return "Respuesta inesperada del servidor: \(message ?? "")"
            case .informational(let code):
                return "Código informativo HTTP: \(code)"
            case .redirection(let code):
                return "Redirección HTTP: \(code)"
            case .clientError(let code):
                return "Error de cliente HTTP: \(code)"
            case .serverError(let code):
                return "Error del servidor HTTP: \(code)"
            case .custom(let msg):
                return "Error personalizado: \(msg)"
            }
        }
    }



