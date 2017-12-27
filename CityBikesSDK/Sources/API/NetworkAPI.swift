//
// NetworkAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire
import SwiftyJSON



enum NetworkEndpoint {
    case getNetworks(fields: [CBFields]?)
    case getStationsForNetwork(networkId: String)
}
/**
 * enum for parameter fields
 */
public enum CBFields: String { 
    case id = "id"
    case name = "name"
    case href = "href"
    case company = "company"
    case location = "location"
}

class NetworkRouter: BaseRouter {

    var endPoint: NetworkEndpoint

    init(endPoint: NetworkEndpoint) {
        self.endPoint = endPoint
    }

    override var method: HTTPMethod {
        switch endPoint {
        case .getNetworks: return .get
        case .getStationsForNetwork: return .get
        }
    }

    override var encoding: ParameterEncoding? {
        switch endPoint {
        case .getNetworks: return URLEncoding()
        case .getStationsForNetwork: return URLEncoding()
        }
    }

    override var path: String {
        switch endPoint {
        case .getNetworks:
            return "/networks"
        case .getStationsForNetwork(let networkId):
            var path = "/networks/{networkId}"
            path = path.replacingOccurrences(of: "{networkId}", with: "\(networkId)")
            return path
        }
    }

    override var parameters: APIParams {
        switch endPoint {
        case .getNetworks(let fields):
            
            var params: APIParams = [:]
            if let fields = fields {
                params?["fields"] = fields
            }
            return params
        case .getStationsForNetwork(_):
            return nil
        }
    }

}

open class NetworkAPIManager {
    
    public init() { }
    
    /**
     Get all the networks.
     
     - parameter fields: (query) Fields can be filtered to limit the fields you want the results to be composed of. (optional)
     - returns: Request>
     */
    @discardableResult public func getNetworks(fields: [CBFields]? = nil, completion: @escaping (_ result: CBNetworksList?,  _ error: Error?, _ response: Alamofire.DataResponse<Any>) -> ()) -> Request? {

        let router = NetworkRouter(endPoint: .getNetworks(fields: fields))
        guard let urlRequest = router.urlRequest else { return nil }
 
        return SwiftSDK.shared.sessionManager.request(urlRequest).validate().responseJSON(completionHandler: { (response) in
            if let error = response.result.error { return completion(nil,  error, response) }
            let value = response.result.value!
            let json = JSON(value)
            do {
                let object = try CBNetworksList(json: json)
                return completion(object, nil, response)
            } catch let error {
                return completion(nil, error, response)
            }
        })
    }
    
    /**
     Get the details of a specific network, including it's bike stations.
     
     - parameter networkId: (path) ID of the network to get it&#39;s stations. 
     - returns: Request>
     */
    @discardableResult public func getStationsForNetwork(networkId: String, completion: @escaping (_ result: CBNetworkDetails?,  _ error: Error?, _ response: Alamofire.DataResponse<Any>) -> ()) -> Request? {

        let router = NetworkRouter(endPoint: .getStationsForNetwork(networkId: networkId))
        guard let urlRequest = router.urlRequest else { return nil }
 
        return SwiftSDK.shared.sessionManager.request(urlRequest).validate().responseJSON(completionHandler: { (response) in
            if let error = response.result.error { return completion(nil,  error, response) }
            let value = response.result.value!
            let json = JSON(value)
            do {
                let object = try CBNetworkDetails(json: json)
                return completion(object, nil, response)
            } catch let error {
                return completion(nil, error, response)
            }
        })
    }
    
}
