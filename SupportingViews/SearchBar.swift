//
//  SearchBar.swift
//  SupportingViews
//
//  Created by Martin Stamenkovski on 8.12.20.
//

import SwiftUI


public struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var focusChanged: Bool
    
    var onTextChanged: ((String) -> Void)?
    
    public init(_ text: Binding<String>, focusChanged: Binding<Bool>) {
        self._text = text
        self._focusChanged = focusChanged
        self.onTextChanged = nil
    }
    
    public init(_ text: Binding<String>, focusChanged: Binding<Bool>, _ onTextChanged: @escaping ((String) -> Void)) {
        self._text = text
        self._focusChanged = focusChanged
        self.onTextChanged = onTextChanged
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {
        var parent: SearchBar
        
        init(parent: SearchBar) {
            self.parent = parent
        }
        
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.parent.text = searchText
            self.parent.onTextChanged?(searchText)
        }
        
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.parent.focusChanged = true
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
            self.parent.focusChanged = false
            self.parent.text = ""
            self.parent.onTextChanged?("")
            searchBar.resignFirstResponder()
        }
       
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.parent.focusChanged = false
            searchBar.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(parent: self)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }
    
    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        if focusChanged {
            uiView.becomeFirstResponder()
        }
    }
}
