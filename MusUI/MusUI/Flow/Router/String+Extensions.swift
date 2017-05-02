//
//  String+Extensions.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

extension String {
    func split(_ delimiter: String) -> [String] {
        let components = self.components(separatedBy: delimiter)
        return components != [""] ? components : []
    }

    func queryParameters() -> [String: String] {
        var parameters = [String: String]()

        let separatorCharacters = CharacterSet(charactersIn: "&;")
        self.components(separatedBy: separatorCharacters).forEach { (pair) in

            if let equalSeparator = pair.range(of: "=") {
                let name = pair.substring(to: equalSeparator.lowerBound)
                let value = pair.substring(from: pair.index(equalSeparator.lowerBound, offsetBy: 1))
                let cleaned = value.removingPercentEncoding ?? value

                parameters[name] = cleaned
            }
        }

        return parameters
    }

    func navigator_encoded() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }

    func navigator_decoded() -> String {
        return removingPercentEncoding ?? self
    }
}
