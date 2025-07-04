//
//  NetworkManager.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation
import Combine

final class NetworkManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: url)
        request.timeoutInterval = 20
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .eraseToAnyPublisher()
    }
    
    private static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
}
