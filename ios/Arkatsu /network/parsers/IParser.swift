//
//  IParse.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 11.02.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}
