//
//  RequestSender.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class RequestSender: IRequestSender {

    // MARK: Private fields
    private let session = URLSession.shared

    // RequestConfig
    func send<Parser>(config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model>) -> Void) {
        // Checks if it is possible to continue with given url
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(Result.error("Given URL is incorrect"))
            return
        }
        // Creates a new task
        let task = session.dataTask(with: urlRequest) { (data: Data?, _: URLResponse?, error: Error?) in
            // Checks if there are any errors
            if let error = error {
                completionHandler(Result.error(error.localizedDescription))
                return
            }
            guard let data = data, let parsedModel = config.parser.parse(data: data) else {
                completionHandler(Result.error("Cannot parse data"))
                return
            }

            // If success, reports it
            completionHandler(Result.success(parsedModel))
        }

        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }

    // RequestConfigAllDetails
    func send<Model, Parser>(config: RequestConfigAllDetails<Model, Parser>, completionHandler: @escaping (Result<[Model]>) -> Void) {
        // Checks if it is possible to continue with given url
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(Result.error("Given URL is incorrect"))
            return
        }
        // Creates a new task
        let task = session.dataTask(with: urlRequest) { (data: Data?, _: URLResponse?, error: Error?) in
            // Checks if there are any errors
            if let error = error {
                completionHandler(Result.error(error.localizedDescription))
                return
            }
            guard let data = data, let parsedModel = config.parser.parse(data: data) else {
                completionHandler(Result.error("Cannot parse data"))
                return
            }

            // If success, reports it
            completionHandler(Result.success(parsedModel))
        }

        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
}
