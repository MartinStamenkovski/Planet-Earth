//
//  PEError.swift
//  Helpers
//
//  Created by Martin Stamenkovski on 19.12.20.
//

import SwiftUI
import Extensions

public enum PEError: Error {
    case permissionDenied(String)
    case message(String)
}

public struct PEErrorView: View {
    let error: PEError
    let onRetry: (() -> Void)
    
    public init(error: PEError, onRetry: @escaping (() -> Void)) {
        self.error = error
        self.onRetry = onRetry
    }
    
    public var body: some View {
        VStack {
            SubErrorView().padding()
        }
    }
    
    private func SubErrorView() -> AnyView {
        switch self.error {
        case .permissionDenied(let message):
            return PermissionNeededView(message: message).toAnyView()
        case .message(let message):
            return VStack(spacing: 12) {
                Text(message)
                    .font(.system(size: 17, weight: .semibold))
                Button("Retry") {
                    self.onRetry()
                }
            }.toAnyView()
        }
    }
    
}

//MARK: Permission Denied View
struct PermissionNeededView: View {
    
    let message: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.system(size: 17, weight: .semibold))
                .multilineTextAlignment(.center)
            Button("Open Settings") {
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                else {
                    return
                }
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }
}

