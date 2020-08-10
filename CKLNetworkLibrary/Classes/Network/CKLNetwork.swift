//
//  CKLNetwork.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 06/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//


import Foundation
import Alamofire

public typealias CompletionList<T: Decodable> = ((Response<[T]>) -> Void)
public typealias CompletionObject<T: Decodable> = ((Response<T>) -> Void)

public struct ResultEmpty: Codable {}

public enum Response<T> {
    case success(T, statusCode: HTTPStatusCode? = nil)
    case failure(error: CKLErrorCustom, statusCode: HTTPStatusCode? = nil, allResponse: DataResponse<T, AFError>? = nil)
}

public enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

public enum ContentType: String {
    case json = "application/json"
}

public class CKLNetwork<R: CKLRequestable> {
    
    // MARK: - Attributes
    
    public lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    // MARK: - Custom methods
    
    public init() {}
    
    /// make request
    /// - Parameters:
    ///   - request: ref CKLRequestable, look in Exemple how pass this interaction
    ///   - completion: return request and status code
    public func makeRequest<T: Decodable>(request: R, _ completion: @escaping ((Response<T>) -> Void)) {
        
        guard CKLReachability.isConnectedToNetwork() else {
            return completion(.failure(error: .noInternet))
        }
        printRequest(request: request)
        
        AF.request(request).validate().responseDecodable(
            queue: DispatchQueue.global(qos: .userInitiated),
            decoder: decoder) { (response: DataResponse<T, AFError>) in
                DispatchQueue.main.async {
                    
                    let statusCode = HTTPStatusCode(rawValue: response.response?.statusCode ?? -1) ?? HTTPStatusCode.notImplemented
                    
                    printResponse(response)
                    
                    switch response.result {
                    case .success(let value):
                        completion(.success(value, statusCode: statusCode))
                    case .failure(let error):
                        self.failure(response: response, error: error, statusCode: statusCode, completion)
                    }
                }
        }
    }
    
    
    /// make request to MultipartFormData
    /// - Parameters:
    ///   - router: router provide by CKRequestable implementation
    ///   - params: others infos to send with data
    ///   - data: data midia
    ///   - mediaType: CKLMediaType
    ///   - completion: return request and status code
    func makeUpload<T: Decodable>( router: R, params: [String:Any], data: Data, mediaType: CKLMediaType, _ completion: @escaping ((Response<T>) -> Void)) {
        printRequest(request: router)
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data,
                                         withName: mediaType.name(),
                                         fileName: mediaType.endPath(),
                                         mimeType: mediaType.fileExtensionPath())
                
                for (key, value) in params {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: true) ?? Data(), withName: key)
                }
        },
            to: router.urlRequest?.description ?? "", usingThreshold: UInt64.init(),
            method: router.urlRequest?.method ?? .post,
            headers: router.urlRequest?.headers)
            .uploadProgress(closure: { progress in
                if isShowLog {
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
            }).responseDecodable(
                queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default),
                decoder: router.getDecoder()) { ( response: DataResponse<T, AFError>) in
                    DispatchQueue.main.async {
                        let statusCode = HTTPStatusCode(rawValue: response.response?.statusCode ?? -1) ?? HTTPStatusCode.notImplemented
                        printResponse(response)
                        switch response.result {
                        case .success(let value):
                            completion(.success(value, statusCode: statusCode))
                        case .failure(let error):
                            self.failure(response: response, error: error, statusCode: statusCode, completion)
                        }
                    }
        }
    }
    
    func failure<T: Decodable>(response: DataResponse<T, AFError>, error: AFError, statusCode: HTTPStatusCode, _ completion: @escaping ((Response<T>) -> Void)) {
        
        let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        
        guard
            error.localizedDescription == err.localizedDescription,
            let emptyData = ResultEmpty() as? T
            else {
                printResponse(response)
                switch statusCode {
                case .unprocessableEntity:
                    let errorBussiness = response.data?.CKLDecode() ?? CKLErrorBusiness()
                    return  completion(.failure(error: .business(errorBussiness), statusCode: statusCode))
                case .unauthorized:
                    return  completion(.failure(error:.authentication , statusCode: statusCode, allResponse: response))
                default:
                    if (response.error as NSError?)?.code != NSURLErrorCancelled {
                        return completion(.failure(error: .generic, statusCode: statusCode, allResponse: response))
                    }
                }
                return
        }
        
        return completion(.success(emptyData))
    }
}

// MARK: - Debug prints

private func printRequest(request: CKLRequestable?) {
    
    guard isShowLog else {
        return
    }
    
    #if DEBUG
    print("\n\n**********  REQUEST   **************")
    print("\(request?.urlRequest?.httpMethod ?? "") - URL: ", request?.urlRequest?.url ?? "")
    print("HEADER: ", request?.urlRequest?.allHTTPHeaderFields?.CKLToJson() ?? "")
    print("BODY: ", request?.parameters ?? "")
    print("****************************************\n\n")
    #endif
}

private func printResponse<T: Decodable>(_ response: DataResponse<T, AFError>) {
    guard isShowLog else {
        return
    }
    
    #if DEBUG
    print("\n\n**********  RESPONSE   **************")
    
    let statusCode = response.response?.statusCode ?? -1
    let httpMethod = response.request?.httpMethod ?? ""
    let url = response.request?.description ?? ""
    
    print("STATUS_CODE: \(statusCode) - \(httpMethod) - URL: ", url)
    
    do {
        if let json = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any] {
            print("RESULT: \(json)")
        } else if let json = try JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [[String: Any]] {
            print("RESULT: \(json)")
        }
    } catch let error as NSError {
        print("Failed to parse Result: \(error.localizedDescription)")
    }
    
    print("****************************************\n\n")
    #endif
}

