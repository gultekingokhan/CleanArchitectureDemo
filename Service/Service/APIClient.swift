//
//  APIClient.swift
//  Service
//
//  Created by Gökhan Gültekin on 2020-02-06.
//  Copyright © 2020 Gökhan Gültekin. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    static func request(configuration: APIRouter.RequestConfiguration, completion: @escaping(Result<Data>) -> Void)
    static func upload(configuration: APIRouter.RequestConfiguration, completion: @escaping(Result<Data>) -> Void)
    static func cancelRequests()
}

final class APIClient: APIClientProtocol {
    
    static func request(configuration: APIRouter.RequestConfiguration, completion: @escaping(Result<Data>) -> Void) {
        
        guard var url = APIRouter.makeURL(path: configuration.path) else { fatalError("Broken URL") }
        
        if let urlComponents = configuration.urlComponents {
            for component in urlComponents { url.appendPathComponent(component) }
        }
        
        let encoding: ParameterEncoding = configuration.method == .get ? URLEncoding.default : JSONEncoding.default
        
        DispatchQueue.global(qos: .background).async {
            
            Alamofire.request(url, method: configuration.method, parameters: configuration.body, encoding: encoding, headers: configuration.headers).responseData { (response) in
                
                guard let code = response.response?.statusCode else {
                    let error = XError(code: -1, message: "No internet connection", type: .system)
                    completion(.failure(error))
                    return
                }
                
                if let data = response.data {
                    
                    let body =  configuration.body == nil ? "<No body>" : "\(configuration.body!)"
                    
                    var logs = "\n👉 URL: \(url)\n👉 Body: \(body)\n👉 Status code: \(code)"
                    // Uncomment if you want to print response too.
                     let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                     logs = logs + "\n👉 Response: \n\(json ?? response)"
                     
                    print(logs)
                }
                
                switch code {
                case 400:
                    
                    let error = XError(code: code, message: "Bad request", type: .brokenAPI)
                    completion(.failure(error))
                    
                    break
                case 500:
                    
                    let error = XError(code: code, message: "Bad request or broken API 💥", type: .brokenAPI)
                    completion(.failure(error))
                    
                case 200:
                    
                    switch response.result {
                    case .success(let data):
                        
                        completion(.success(data))
                        
                    case .failure(let error):
                        
                        let error = XError(code: code, message: "An error came from the API: \(error.localizedDescription)", type: .system)
                        completion(.failure(error))
                    }
                default:
                    let error = XError(code: code, message: "A generic error", type: .system)
                    completion(.failure(error))
                    break
                }
            }
        }
    }
    
    static func upload(configuration: APIRouter.RequestConfiguration, completion: @escaping(Result<Data>) -> Void) {
        
        guard let url = APIRouter.makeURL(path: configuration.path) else {
            fatalError("Broken URL")
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let body = configuration.body {
                
                for (key, value) in body {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            
            if let imageDatas = configuration.files  {
                
                var index = 0
                for data in imageDatas {
                    multipartFormData.append(data, withName: "image-\(index)", fileName: "image-\(index).png", mimeType: "image/png")
                    index += 1
                }
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: configuration.method, headers: configuration.headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    
                    guard let error = response.error else {
                        completion(.success(response.data!))
                        return
                    }
                    
                    completion(.failure(XError(code: 500, message: error.localizedDescription, type: .brokenAPI)))
                }
            case .failure(let error):
                completion(.failure(XError(code: 500, message: error.localizedDescription, type: .brokenAPI)))
            }
        }
    }
    
    static func cancelRequests() {
        
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
    }
}

