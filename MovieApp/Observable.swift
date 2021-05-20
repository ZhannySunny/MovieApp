//
//  Observable.swift
//  MovieApp
//
//  Created by Zhaniya on 16.03.2021.
//

import Foundation

final class Observable<T> {

    typealias CompletionHandler = ((T) -> Void)

    var observers: [Int: CompletionHandler] = [:]

    var value: T {
        didSet {
            notifyObservers(observers)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func addObserver(completion: @escaping CompletionHandler) {
        let key = (observers.keys.max() ?? 0) + 1
        observers[key] = completion
    }

    private func notifyObservers(_ observers: [Int: CompletionHandler]) {
        observers.forEach { $0.value(value) }
    }

    deinit {
        observers.removeAll()
    }
}
