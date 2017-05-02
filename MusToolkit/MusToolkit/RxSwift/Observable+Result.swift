//
//  Observable+Result.swift
//  MusToolkit
//
//  Created by Joachim Kret on 18/03/2017.
//  Copyright © 2017 Joachim Kret. All rights reserved.
//

import Foundation
import Result
import RxSwift

extension Observable {
    public func mapResult() -> Observable<Result<Element, AnyError>> {
        return map { element in
            return Result.success(element)
        }
        .catchError { (error) -> Observable<Result<Element, AnyError>> in
            let result = Result<Element, AnyError>(error: AnyError(error))
            return Observable<Result<Element, AnyError>>.just(result)
        }
    }
}
