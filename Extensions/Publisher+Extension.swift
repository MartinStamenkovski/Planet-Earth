//
//  Publisher+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 12.12.20.
//

import Combine

extension Publisher {
    
    public func sink(_ completion: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable {
        return self.sink { failure in
            switch failure {
            case .failure(let error):
                completion(.failure(error))
            case .finished: break
            }
        } receiveValue: { output in
            completion(.success(output))
        }
    }
}
