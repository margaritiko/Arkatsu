//
//  IRequestSender.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

struct RequestConfigAllDetails<Model, Parser: IParser> where Parser.Model == [Model] {
    let request: IRequest
    let parser: Parser
}

// Describes a result of an operation
enum Result<Model> {
    case success(Model)
    case error(String)
}

protocol IRequestSender {
    func send<Parser>(config: RequestConfig<Parser>, completionHandler: @escaping (Result<Parser.Model>) -> Void )
    func send<Model, Parser>(config: RequestConfigAllDetails<Model, Parser>, completionHandler: @escaping (Result<[Model]>) -> Void )
}
