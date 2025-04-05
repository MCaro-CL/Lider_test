import Foundation

public struct NetworkingDataSourceImp: NetworkingDataSource {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    public func dowload(url: URL,method: String, headers: [[String : String]], body: Data?) async throws -> (Data,URLResponse) {
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = method
        
        if !headers.isEmpty {
            for header in headers {
                for (key, value) in header {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        if let body = body {
            request.httpBody = body
        }
        let response = try await session.data(for: request)
        return response
    }
}
