//
//  CKLRequestable.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import Foundation
import Alamofire

public protocol CKLRequestable: URLRequestConvertible {
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var path: String { get }
    var nameKeyAuthorization: String { get }
    var tokenAuthorization: String { get }
    func asURLRequest() throws -> URLRequest
    func getDecoder() -> JSONDecoder
}

extension CKLRequestable {
    
    /// returns the name of field authorizing requests
    public var nameKeyAuthorization: String {
        keyNameAuthorization
    }
    
    /// returns the token when authorizing requests
    public var tokenAuthorization: String {
        valueTokenAuthorization
    }
     
    /// Check if url with parameters is a valid url
    /// - Throws: Error encoding failed
    /// - Returns: Url Request with parameters
    public func asURLRequest() throws -> URLRequest {
        
        guard let url = URL(string: baseURL) else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
       
        urlRequest.setValue(tokenAuthorization, forHTTPHeaderField: nameKeyAuthorization)
        
        if let parameters = parameters {
            do {
                switch method {
                case .get:
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                case .post, .patch:
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                default:
                    break
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    public func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
