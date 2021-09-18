//
//  URLSession.swift
//  Libra
//
//  Created by Catalina on 17/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine

extension URLSession {
    
    private func handleError(publisher: DataTaskPublisher) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        return publisher.tryMap { (data, response) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            let decoder = JSONDecoder()
            if !((200...299).contains(statusCode)) {
                if !data.isEmpty {
                    let result = try decoder.decode(LabelledHTTPError.self, from: data)
                    throw ResponseError.vanilla(code: result.code, message: result.message)
                }
                throw ResponseError.unexpected("Unknown server side error")
            }
            return (data, httpResponse)
        }.eraseToAnyPublisher()
    }
    
    func errorHandledPublisher(for urlRequest: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        self.handleError(publisher: self.dataTaskPublisher(for: urlRequest))
    }
    
    func errorHandledPublisher(for url: URL) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        self.handleError(publisher: self.dataTaskPublisher(for: url))
    }
    
    func errorHandledPublisherWithResponse<T: Decodable>(for urlRequest: URLRequest, using jsonStruct: T.Type) -> AnyPublisher<(T, HTTPURLResponse), Error> {
        self.handleError(publisher: self.dataTaskPublisher(for: urlRequest))
            .tryMap { (data, response) in
                let decoder = JSONDecoder()
                return (try decoder.decode(T.self, from: data), response)
            }.eraseToAnyPublisher()
    }
    
    func errorHandledPublisherWithResponse<T: Decodable>(for url: URL, using jsonStruct: T.Type) -> AnyPublisher<(T, HTTPURLResponse), Error> {
        self.handleError(publisher: self.dataTaskPublisher(for: url))
            .tryMap { (data, response) in
                let decoder = JSONDecoder()
                return (try decoder.decode(T.self, from: data), response)
            }.eraseToAnyPublisher()
    }
    
    func errorHandledPublisher<T: Decodable>(for urlRequest: URLRequest, using jsonStruct: T.Type) -> AnyPublisher<T, Error> {
        self.handleError(publisher: self.dataTaskPublisher(for: urlRequest))
            .tryMap { (data, _) in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }.eraseToAnyPublisher()
    }
    
    func errorHandledPublisher<T: Decodable>(for url: URL, using jsonStruct: T.Type) -> AnyPublisher<T, Error> {
        self.handleError(publisher: self.dataTaskPublisher(for: url))
            .tryMap { (data, _) in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }.eraseToAnyPublisher()
    }
    
    
}
