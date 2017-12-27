//  SwiftyJsonPrimitiveExtension.swift
//  Created by Nicolas Parimeros on 19/01/2017.

import Foundation
import SwiftyJSON

enum SwiftyJsonPrimitiveExtension: Error {
    case parsingTypeError
}

extension Int {
    init(json: JSON) throws {
        if let value = json.int {
            self = value
        } else {
            throw SwiftyJsonPrimitiveExtension.parsingTypeError
        }
    }
}

extension Int32 {
    init?(json: JSON) throws {
        if let value = json.int32 {
            self = value
        }
        return nil
    }
}

extension Int64 {
    init?(json: JSON) throws {
        if let value = json.int64 {
            self = value
        }
        return nil
    }
}

extension Float {
    init?(json: JSON) throws {
        if let value = json.float {
            self = value
        }
        return nil
    }
}

extension Double {
    init?(json: JSON) throws {
        if let value = json.double {
            self = value
        }
        return nil
    }
}

extension Bool {
    init?(json: JSON) throws {
        if let value = json.bool {
            self = value
        }
        return nil
    }
}

extension String {
    init?(json: JSON) throws {
        if let value = json.string {
            self = value
        }
        return nil
    }
}

extension Array where Iterator.Element == Double {
    init(json: JSON) throws {
        let array = json.array
        var models = [Double]()
        for object in array! {
            let jsonObject = object.doubleValue
            models.append(jsonObject)
        }
        self.init(models)
    }
}