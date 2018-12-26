//
//  Box.swift
//  Maponia
//
//  Created by Daniel Szasz on 5/4/18.
//  Copyright © 2018 Mobiversal SRL. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var modelListener: Listener?

    var value: T {
        didSet {
            listener?(value)
            modelListener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bindRevert(listener: Listener?) {
        self.modelListener = listener
        modelListener?(value)
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

class BoxSubject<T>: Box<T> {
    var listeners: [Listener] = []

    override var value: T {
        didSet {
            self.listener?(value)
            self.modelListener?(value)
            self.listeners.forEach({$0(value)})
        }
    }
}
