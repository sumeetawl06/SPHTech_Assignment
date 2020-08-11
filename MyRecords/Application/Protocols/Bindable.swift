//
//  Bindable.swift
//  Desk
//
//  Created by Deskera on 9/20/19.
//  Copyright © 2019 Deskera. All rights reserved.
//

import Foundation

protocol BindableProtocol {
    associatedtype ListenerCallback
    associatedtype ValueType
    
    var value: ValueType { get set }

    func bind(listener: ListenerCallback)
    
    func bindAndFireEvent(listener: ListenerCallback)
    
    func fireEvent()
}


class Bindable<T> : NSObject, BindableProtocol {
    typealias ListenerCallback = (T) -> ()
    typealias ValueType = T
    
    private var listener: ListenerCallback?
    
    var value: ValueType {
        didSet {
            fireEvent()
        }
    }
    
    init(_ value: ValueType) {
        self.value = value
    }
    
    func bind(listener: @escaping ListenerCallback) {
        self.listener = listener
    }
    
    func bindAndFireEvent(listener: @escaping ListenerCallback) {
        bind(listener: listener)
        listener(value)
    }
    
    func fireEvent() {
        listener?(self.value)
    }
}
