import Foundation

protocol DetailServicing {
    func fetchWeather(id: Int, completion: @escaping (Result<Weather, APIError>) -> Void)
}

struct DetailService {
    private let requestManager: Requestable
    
    init(requestManager: Requestable = RequestManager()) {
        self.requestManager = requestManager
    }
}

extension DetailService: DetailServicing {
    func fetchWeather(id: Int, completion: @escaping (Result<Weather, APIError>) -> Void) {
        let endpoint: DetailEndpoint = .fetchWeather(id)
        requestManager.request(with: endpoint) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
