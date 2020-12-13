//
//  URLSession+Extensions.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 12.12.20.
//

import Combine


extension URLSession {
    
    public enum APIError: Error, LocalizedError {
        case reason(String)
    }
    
    public func dataTaskPublisherWithError(for url: URL) -> AnyPublisher<Data, APIError> {
        return self.dataTaskPublisher(for: url).tryCompactMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw APIError.reason("Something went wrong, try again.")
            }
            return data
        }.mapError { error in
            if let error = error as? APIError {
                return error
            }
            return APIError.reason(error.localizedDescription)
        }.eraseToAnyPublisher()
    }
}
