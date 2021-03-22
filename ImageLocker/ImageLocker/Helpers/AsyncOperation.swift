//
//  AsyncOperation.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 22.03.2021.
//  Copyright © 2021 Виталий Субботин. All rights reserved.
//

import Foundation

open class AsyncOperation: Operation {
    
    public enum State: String {
        case ready
        case executing
        case finished
        
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    
    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    public override var isReady: Bool {
        return state == .ready && super.isReady
    }
    
    public override var isExecuting: Bool {
        return state == .executing
    }
    
    public override var isFinished: Bool {
        return state == .finished
    }
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    public override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    open override func cancel() {
        super.cancel()
        state = .finished
    }
}
