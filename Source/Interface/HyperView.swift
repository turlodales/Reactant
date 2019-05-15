//
//  HyperView.swift
//  Hyperdrive
//
//  Created by Tadeas Kriz on 17/03/2019.
//  Copyright © 2019 Brightify. All rights reserved.
//

import UIKit

public protocol ComposableHyperView: AnyObject {
    associatedtype State: HyperViewState
    associatedtype Action

    func set(state: State)

    func apply(change: State.Change)

    static var sourceFilePath: String { get }
}

public protocol HyperView: ComposableHyperView {
    init(actionPublisher: ActionPublisher<Action>)
}

open class HyperViewBase: UIView {
    public init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported!")
    }
}
