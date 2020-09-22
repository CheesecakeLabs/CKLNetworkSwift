//
//  MediaType.swift
//  CKLNetworkLibrary
//
//  Created by Ricardo Cherobin on 15/07/20.
//

import Foundation

/// Types of media that are currently available for support, are only needed to add more file extensions.
public enum CKLMediaType {
    
    case image
    case video(url: URL)
    case pdf
    
    func name() -> String {
        return nameMediaType
    }
    
    func endPath() -> String {
        switch self {
        case .image:
            return name() + ".jpg"
        case .video:
            return name() + ".mp4"
        case .pdf:
            return name() + ".pdf"
        }
    }
    
    func fileExtensionPath() -> String {
        switch self {
        case .image:
            return "image/jpg"
        case .video:
            return "video/mp4"
        case .pdf:
            return "pdf"
        }
    }
}

