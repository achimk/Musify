//
//  Navigator.swift
//  MusUI
//
//  Created by Joachim Kret on 23/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

// MARK: NavigatorType

public protocol NavigatorType {
    func parse(url: URL, payload: Any?) -> LocationType?
    func url(from: String) -> URL?
}

extension NavigatorType {
    public func parse(url: URL) -> LocationType? {
        return parse(url: url, payload: nil)
    }
}

// MARK: Navigator

public struct Navigator: NavigatorType {
    public let scheme: String
    public let delimiter: String
    public var routes: Array<String> = []

    // MARK: Init

    public init(scheme: String, delimiter: String = ":") {
        self.scheme = "\(scheme)://"
        self.delimiter = delimiter
    }

    // MARK: Parse

    public func parse(url: URL, payload: Any? = nil) -> LocationType? {
        guard let range = url.absoluteString.range(of: scheme) else {
            return nil
        }

        let path = url.absoluteString.substring(from: range.upperBound)

        guard !(path.contains("?") || path.contains("#")) else {
            return parseComponents(url: url, payload: payload)
        }

        let results: [ParseResult] = routes
            .flatMap {
                return findMatch(routeString: $0, pathString: path)
            }
            .sorted { (r1: ParseResult, r2: ParseResult) in
                if r1.concreteMatchCount == r2.concreteMatchCount {
                    return r1.wildcardMatchCount > r2.wildcardMatchCount
                } else {
                    return r1.concreteMatchCount > r2.concreteMatchCount
                }
            }

        if let result = results.first {
            return Location(
                scheme: scheme,
                path: result.route,
                arguments: result.arguments,
                payload: payload
            )
        }
        
        return nil
    }

    // To URL

    public func url(from: String) -> URL? {
        return URL(string: "\(scheme)\(from.navigator_encoded())")
    }

    // MARK: Private

    private typealias ParseResult = (
        route: String,
        arguments: Dictionary<String, String>,
        concreteMatchCount: Int,
        wildcardMatchCount: Int
    )

    private func parseComponents(url: URL, payload: Any? = nil) -> LocationType? {
        guard let route = url.host else { return nil }

        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var arguments = [String : String]()

        urlComponents?.queryItems?.forEach { queryItem in
            arguments[queryItem.name] = queryItem.value
        }

        if let fragment = urlComponents?.fragment {
            arguments = fragment.queryParameters()
        }

        return Location(
            scheme: scheme,
            path: route,
            arguments: arguments,
            payload: payload
        )
    }

    private func findMatch(routeString: String, pathString: String) -> ParseResult? {
        let routes = routeString.split(delimiter)
        let paths = pathString.split(delimiter)

        guard routes.count == paths.count else { return nil }

        var arguments = Dictionary<String, String>()
        var concreteMatchCount = 0
        var wildcardMatchCount = 0

        for (route, path) in zip(routes, paths) {
            if route.hasPrefix("{") {
                let key = route
                    .replacingOccurrences(of: "{", with: "")
                    .replacingOccurrences(of: "}", with: "")
                arguments[key] = path.navigator_decoded()

                wildcardMatchCount += 1
                continue
            }

            if route == path {
                concreteMatchCount += 1
            } else {
                return nil
            }
        }

        return (route: routeString,
                arguments: arguments,
                concreteMatchCount: concreteMatchCount,
                wildcardMatchCount: wildcardMatchCount)
    }
}
