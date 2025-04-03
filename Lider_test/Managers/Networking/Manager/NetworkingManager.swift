import Foundation

public final class NetworkingManager: NetProtocol {
    private let dataSource: NetworkingDataSource
    
    public init(dataSource: NetworkingDataSource) {
        self.dataSource = dataSource
    }
    
    public func download<C: Codable, T: Codable>(_ request: APIRequest<C, T>) async -> Result<APIResponse<T>, HTTPError> {
        let uri = parseURL(baseURL: request.baseUrl, params: request.params)
        
        guard let url = URL(string: uri) else {
            return .failure(.invalidURL(uri))
        }
        
        let method = request.method.rawValue
        
        var headers: [[String : String]] = []
        
        if !request.headers.isEmpty {
            for header in request.headers {
                headers.append(["\(header.key)": "\(header.value)"])
            }
        }
        
        var json: Data?
        if let raw = request.rawBody {
                json = raw
        } else if let body = request.body {
            do {
                if request.headers.contains(where: { $0.key == "Content-Type" && $0.value == "application/x-www-form-urlencoded" }) {
                    let encoder = JSONEncoder()
                    let encodedData = try encoder.encode(body)
                    guard let dictionary = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String: Any] else {
                        return .failure(.invalidBody(encodedData))
                    }
                    let formBody = dictionary.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                    json = formBody.data(using: .utf8)
                } else {
                    json = try JSONEncoder().encode(body)
                }
            } catch {
                return .failure(.invalidBody(body as! Data))
            }
        } else {
            json = nil
        }
        
        do {
            let response = try await dataSource.dowload(url: url, method: method, headers: headers, body: json)
            return await parse(response, responseType: request.responseType)
        } catch {
            return .failure(.custom("Error inesperado al realizar la solicitud: \\(error.localizedDescription)"))
        }
    }
    
}

extension NetworkingManager {
    private func parse<R: Codable>(_ data: (data: Data, response: URLResponse), responseType: R.Type) async -> Result<APIResponse<R>, HTTPError> {
        guard let response = data.response as? HTTPURLResponse else {
            return .failure(.invalidResponse(data.data.toString() ?? "sin data response"))
        }
//        print("status code: \(response.statusCode)/",data.data.toString())
        switch response.statusCode {
            case 200..<300:
                if data.data.isEmpty {
                    return .success(APIResponse(statusCode: response.statusCode, value: nil, headers: response.allHeaderFields))
                }
                do {
                    let value = try JSONDecoder().decode(responseType, from: data.data)
                    return .success(APIResponse(statusCode: response.statusCode,value: value,rawValue: data.data,headers: response.allHeaderFields))
                } catch {
                    debugPrint("Error al decodificar el JSON: \(error)")
                    return .failure(.invalidDecoder(data.data))
                }
            case 300..<400:
                return .failure(.redirection(response.statusCode))
            case 400..<500:
                return .failure(.clientError(response.statusCode))
            case 500..<600:
                return .failure(.serverError(response.statusCode))
                
            default:
                return .failure(.invalidResponse("Invalid response"))
        }
    }
    
    private func parseURL(baseURL: String, params: [HTTPParam]) -> String {
        guard !params.isEmpty else { return baseURL }
        let queryString = params.map { "\($0.key)=\($0.value.URLEncoded())" }
            .joined(separator: "&")
        let separator = baseURL.contains("?") ? "&" : "?"
        return baseURL + separator + queryString
    }
}

