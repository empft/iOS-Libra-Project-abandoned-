//
//  URLSession.swift
//  Libra
//
//  Created by Catalina on 17/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
    case InvalidResponseCode
    case FailureMessage(String)
}

extension URLSession {
    // Handle simple Http code error and return a publisher
    private func dataTaskErrorHandled(for urlRequest: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse),Error> {
        self.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                if !((200...299).contains((response as! HTTPURLResponse).statusCode)) {
                    throw NetworkError.InvalidResponseCode
                }
                return (data, response)
        }.eraseToAnyPublisher()
    }
    
    // return decoded data with everything handled
    func getData<T: Decodable & JsonBase>(for urlRequest: URLRequest, using jsonStruct: T) -> AnyPublisher<T.ResultType,Error> {
        self.dataTaskErrorHandled(for: urlRequest)
        .map { $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .tryMap { decoded in
            if decoded.success {
                return decoded.data
            } else {
                throw NetworkError.FailureMessage(decoded.message ?? "No Failure Message")
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .unspecified))
        .eraseToAnyPublisher()
    }
    
    // return decoded boolean result with everything handled
    func getBool(for urlRequest: URLRequest) -> AnyPublisher<Bool,Error> {
        self.dataTaskErrorHandled(for: urlRequest)
        .map { $0.data }
        .decode(type: JsonBool.self, decoder: JSONDecoder())
        .tryMap { decoded in
            if decoded.success {
                return decoded.data
            } else {
                throw NetworkError.FailureMessage(decoded.message ?? "No Failure Message")
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .unspecified))
        .eraseToAnyPublisher()
    }
    
    // return decoded data and response with everything handled
    func getDataResponse<T: Decodable & JsonBase>(for urlRequest: URLRequest, using jsonStruct: T) -> AnyPublisher<(data: T.ResultType, response: URLResponse),Error> {
        self.dataTaskErrorHandled(for: urlRequest)
        .tryMap { (data, response) in
            let decoded = try JSONDecoder().decode(T.self, from: data)
            if decoded.success {
                return (decoded.data,response)
            } else {
                throw NetworkError.FailureMessage(decoded.message ?? "No Failure Message")
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .unspecified))
        .eraseToAnyPublisher()
    }
    
    // return decoded boolean result and response with everything handled
    func getBoolResponse(for urlRequest: URLRequest) -> AnyPublisher<(data: Bool, response: URLResponse),Error> {
        self.dataTaskErrorHandled(for: urlRequest)
        .tryMap { (data, response) in
            let decoded = try JSONDecoder().decode(JsonBool.self, from: data)
            if decoded.success {
                return (decoded.data,response)
            } else {
                throw NetworkError.FailureMessage(decoded.message ?? "No Failure Message")
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .unspecified))
        .eraseToAnyPublisher()
    }
    
    func sendRequest(for urlRequest: URLRequest) -> AnyPublisher<[Error],Never> {
        self.dataTaskErrorHandled(for: urlRequest)
        .map { $0.data }
        .decode(type: JsonType.self, decoder: JSONDecoder())
        .tryMap { decoded in
            if !decoded.success {
                throw NetworkError.FailureMessage(decoded.message ?? "No Failure Message")
            }
            return []
        }.catch { error -> Just<[Error]> in
            return Just([error])
        }
        .subscribe(on: DispatchQueue.global(qos: .unspecified))
        .eraseToAnyPublisher()
    }
}


