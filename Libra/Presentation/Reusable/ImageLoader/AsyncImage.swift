//
//  AsyncImage.swift
//  Libra
//
//  Created by Big Sur on 6/4/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage
    private var cancellable = Set<AnyCancellable>()
    
    // Cache and Request
    private let urlSession: URLSession
    private let cache: NSCache<NSURL, UIImage>
    
    init(
        placeholder: UIImage = UIImage(),
        cache: NSCache<NSURL, UIImage> = .init()
    ) {
        
        self.urlSession = .shared
        self.cache = cache
        self.image = placeholder
    }
    
    private func publisher(for url: URL) -> AnyPublisher<UIImage, Error> {
        if let image = cache.object(forKey: url as NSURL) {
            return Just(image)
                .setFailureType(to: Error.self)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            return urlSession
                .dataTaskPublisher(for: url)
                .map(\.data)
                .tryMap { data in
                    guard let image = UIImage(data: data) else {
                        throw URLError(.badServerResponse, userInfo: [
                            NSURLErrorFailingURLErrorKey: url
                        ])
                    }
                    return image
                }
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveOutput: { [cache] image in
                    cache.setObject(image, forKey: url as NSURL)
                })
                .eraseToAnyPublisher()
        }
    }
    
    func load(from url: URL) {
        publisher(for: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.image = UIImage(named: "broken")!
                }
            }) { image in
                self.image = image
            }
            .store(in: &cancellable)
    }
}
