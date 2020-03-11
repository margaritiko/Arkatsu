//
//  IllustrationRequest.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class Request: IRequest {
    var urlRequest: URLRequest?

    init(url: URL) {
        // Creates a request with given url
        urlRequest = URLRequest(url: url)
    }
}
