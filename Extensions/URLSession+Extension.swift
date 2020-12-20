//
//  URLSession+Extensions.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 12.12.20.
//

import Combine


extension URLSession {
    
   
    public struct APIError: Error, LocalizedError {
        let message: String
        
        init(_ message: String) {
            self.message = message
        }
        
        public var localizedDescription: String {
            return message
        }
        
        public var errorDescription: String? {
            return message
        }
        
        public var failureReason: String? {
            return message
        }
    }
   
    public func dataTaskPublisherWithError(for url: URL) -> AnyPublisher<Data, APIError> {
        return self.dataTaskPublisher(for: url).tryCompactMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse
            else {
                throw APIError("Something went wrong, try again.")
            }
            guard 200..<300 ~= httpResponse.statusCode
            else {
                let description = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                throw APIError(description)
            }
            return data
        }.mapError { error in
            if let error = error as? APIError {
                return error
            }
            return APIError(error.localizedDescription)
        }.eraseToAnyPublisher()
    }
}
