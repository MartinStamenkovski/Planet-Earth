//
//  ViewState.swift
//  Helpers
//
//  Created by Martin Stamenkovski on 20.12.20.
//

import Foundation

@frozen
public enum ViewState {
    case loading
    case success
    case error(PEError)
}
