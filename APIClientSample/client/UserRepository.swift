//
//  UserRepository.swift
//  APIClientSample
//
//  Created by Asakura Shinsuke on 2017/08/30.
//  Copyright © 2017年 Asakura Shinsuke. All rights reserved.
//


import Himotoki
import Alamofire

struct Repository: Decodable {
    let fullName: String
    let ownerAvatarUrl: String
    let language: String?
    let url: String
    let htmlUrl: String
    
    static func decode(_ e: Extractor) throws -> Repository {
        return try Repository(
            fullName: e <| "full_name",
            ownerAvatarUrl: e <| ["owner", "avatar_url"],
            language: e <|? "language",
            url: e <| "url",
            htmlUrl: e <| "html_url"
        )
    }
}

struct  UserRepository: APIRequest {
    var headers: [String : String]? = nil
    var parameters: [String : Any]? = nil
    var userName: String
    
    var path: String {
        return "/users/\(self.userName)/repos"
    }
    var method: HTTPMethod {
        return .get
    }
    typealias Response = [Repository]
    
    init(userName: String) {
        self.userName = userName
    }
    
    func response(from object: Any) throws -> Response {
        return try decodeArray(object)
    }
}
