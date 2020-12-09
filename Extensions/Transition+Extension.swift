//
//  Transition+Extension.swift
//  Extensions
//
//  Created by Martin Stamenkovski on 2.12.20.
//

import SwiftUI

extension AnyTransition {
    
    public static var slideAndFade: AnyTransition {
        let insertion = AnyTransition.slide
            .combined(with: .opacity)
        let removal = AnyTransition.slide
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    public static var insertBottomRemoveTopFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .top)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    public static var insertTopRemoveBottomFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .top)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

