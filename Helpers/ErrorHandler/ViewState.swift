//
//  ViewState.swift
//  Helpers
//
//  Created by Martin Stamenkovski on 20.12.20.
//

import Foundation

@frozen
public enum ViewState<T> {
    case loading
    case success(T)
    case error(PEError)
}
