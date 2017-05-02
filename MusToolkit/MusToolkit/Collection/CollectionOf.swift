//
//  Collection.swift
//  MusToolkit
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation

/**
 CollectionOf
 */
public class CollectionOf<I: Strideable, T>: Collection {
    public typealias Index = I
    public typealias Element = T

    // MARK: Init

    public init() { }

    // MARK: Indexable

    public var startIndex: Index {
        fatalError()
    }

    public var endIndex: Index {
        fatalError()
    }

    public subscript(position: Index) -> Element {
        fatalError()
    }

    public func index(after i: Index) -> Index {
        fatalError()
    }
}

// MARK: Conversion to base collection

extension CollectionOf {
    public func asCollection() -> CollectionOf<Index, Element> {
        return self
    }
}

// MARK: Compose map

extension CollectionOf {
    public func map<R>(selector: @escaping ((Element) -> R)) -> CollectionOf<Index, R> {
        return MapCollectionOf(source: self, resultSelector: selector).asCollection()
    }
}

// MARK: Convenience

extension CollectionOf {
    public static func using<C: Collection>(_ collection: C) -> CollectionOf<C.Index, C.Iterator.Element> where C.Index == I, C.Iterator.Element == T {
        return ProxyCollectionOf(collection: collection).asCollection()
    }
}

/**
 ProxyCollectionOf
 */
public class ProxyCollectionOf<C: Collection>: CollectionOf<C.Index, C.Iterator.Element> where C.Index: Strideable {
    private let collection: C

    // MARK: Init

    public init(collection: C) {
        self.collection = collection
    }

    // MARK: Indexable

    public override var startIndex: Index {
        return collection.startIndex
    }

    public override var endIndex: Index {
        return collection.endIndex
    }

    public override subscript(position: Index) -> Element {
        return collection[position]
    }

    public override func index(after i: Index) -> Index {
        return collection.index(after: i)
    }
}

/**
 MapCollectionOf
 */
public class MapCollectionOf<I: Strideable, SourceType, ResultType>: CollectionOf<I, ResultType> {
    public typealias ResultSelector = ((SourceType) -> ResultType)

    private let source: CollectionOf<Index, SourceType>
    private let resultSelector: ResultSelector

    // MARK: Init

    public init(source: CollectionOf<Index, SourceType>, resultSelector: @escaping ResultSelector) {
        self.source = source
        self.resultSelector = resultSelector
    }

    // MARK: Indexable

    public override var startIndex: Index {
        return source.startIndex
    }

    public override var endIndex: Index {
        return source.endIndex
    }

    public override subscript(position: Index) -> Element {
        return resultSelector(source[position])
    }

    public override func index(after i: Index) -> Index {
        return source.index(after: i)
    }
}
