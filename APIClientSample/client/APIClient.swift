//
//  APIClient.swift
//  APIClientSample
//
//  Created by Asakura Shinsuke on 2017/08/30.
//  Copyright © 2017年 Asakura Shinsuke. All rights reserved.
//

import Alamofire
import Himotoki

enum Result<T> {
    case Success(T)
    case Error(Error)
}

protocol APIRequest {
    var baseeUrl: String { get }
    var headerTemplate: [String : String] { get }
    
    associatedtype Response
    var path: String { get }
    var method: HTTPMethod { get }
    
    var parameters: [String : Any]? { get set }
    var headers: [String : String]? { get set }
    
    func response(from object: Any) throws -> Self.Response
    
}

extension APIRequest {
    var baseeUrl: String {
        return "https://api.github.com"
    }
    var headerTemplate: [String : String] {
        return ["X-Requested-With" : "XMLHttpRequest"]
    }
    var parameters: Any? {
        return nil
    }
    var headers: [String : String]? {
        return nil
    }
    
    func request(finished: @escaping (Result<Self.Response>)->Void) {
        let encoding = JSONEncoding.default
        var header = headerTemplate as Dictionary<String, String>
        headerTemplate.forEach() {
            header[$0.0] = $0.1
        }
        
        let encodedURLString = (baseeUrl + path).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURLString!, method: method, parameters: parameters, encoding: encoding, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                do {
                    let res = try self.response(from: value)
                    finished(Result.Success(res))
                } catch {
                    finished(Result.Error(error))
                }
            case .failure(let error):
                finished(Result<Self.Response>.Error(error))
            }
        }
    }
}
