//
//  SFSafariView.swift
//  Helpers
//
//  Created by Martin Stamenkovski on 28.12.20.
//

import SwiftUI
import SafariServices

public struct SFSafariView: UIViewControllerRepresentable {
  
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<SFSafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariView>) {
        
    }
}
