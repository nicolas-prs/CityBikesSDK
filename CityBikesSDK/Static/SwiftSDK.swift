//
//  SwiftSDK.swift
//
//  Created by Nicolas on 11/07/2017.
//  Copyright © 2017 Nicolas. All rights reserved.
//

import Foundation
import Alamofire

open class SwiftSDK {

    public private(set) var adapter: RequestAdapter?
    public private(set) var sessionManager = SessionManager.default
    public private(set) var baseUrl = ""
    
    public static let shared = SwiftSDK()
    
    private init() {}

    public static func provide(adapter: RequestAdapter?, baseUrl: String) {
        self.shared.adapter = adapter
        self.shared.sessionManager.adapter = adapter
        self.shared.baseUrl = baseUrl
    }

}