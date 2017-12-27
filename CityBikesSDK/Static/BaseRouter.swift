//  BaseRouter.swift
//  Created by Nicolas Parimeros on 10/01/2017.

import Foundation
import Alamofire

typealias APIParams = [String: Any]?

protocol APIConfiguration {
    var method: Alamofire.Method { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
}

class BaseRouter {

    var method: HTTPMethod {
        fatalError("[\(String(describing: type(of: self))) - \(#function))] Must be overridden in subclass")
    }

    var encoding: Alamofire.ParameterEncoding? {
        return JSONEncoding()
    }

    var path: String {
        fatalError("[\(String(describing: type(of: self))) - \(#function))] Must be overridden in subclass")
    }

    var parameters: APIParams {
        fatalError("[\(String(describing: type(of: self))) - \(#function))] Must be overridden in subclass")
    }

    var baseUrlString: String {
        return SwiftSDK.shared.baseUrl
    }

    var urlRequest: URLRequest? {
        guard let baseUrl = NSURL(string: baseUrlString) else { return nil }
        guard let url = baseUrl.appendingPathComponent(path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let encoding = encoding {
            do {
                return try encoding.encode(request, with: parameters)
            } catch let error {
                print("Error encoding request : \(error)")
                return nil
            }
        }

        return request
    }
}
