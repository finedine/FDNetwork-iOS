//
//  FDNetworkRouter.swift
//  FDNetwork
//
//  Created by Emre Ertan on 2.04.2020.
//  Copyright © 2020 Emre Ertan. All rights reserved.
//

import Alamofire

public enum FinedineEndpointTypes {
    case product
    case staging
    case custom(base: String, oldBase: String)
}

public enum FinedineURLTypes: String {
    case baseURL
    case oldBaseURL
}

public enum FinedineURL: String {
    case productBaseURL = "https://api.finedinemenu.com/v1"
    case productOldBaseURL = "http://panel.finedinemenu.com/"
    case stagingBaseURL = "https://finedine-api-staging.herokuapp.com/v1"
    case stagingOldBaseURL = "http://fdmetronic.herokuapp.com/"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

public enum ContentType: String {
    case json = "application/json"
}

public enum FDErrorDomain: String {
    case authenticate = "1001"
    case shop = "1002"
    case tables = "1003"
    case employees = "1004"
    case modifierGroups = "1005"
    case ads = "1007"
    case feedbackForms = "1008"
    case entity = "1009"
    case shopStatus = "1012"
    case dataStatus = "1013"
    case createAndAdd = "1014"
    case sendOrder = "1015"
    case sendKioskOrder = "1016"
    case createTicket = "1017"
    case requestService = "1018"
    case calculateCheckout = "1020"
    case tickets = "1021"
    case ticket = "1022"
    case checkout = "1023"
    case menuFlatList = "1025"
}

public enum FDNetworkRouter: URLRequestConvertible {

    static public var UDID = ""
    static public var token = ""
    static public var appVersion = ""
    static public var URLType: FinedineEndpointTypes = .product

    case devices(shopid: String, pincode: String)
    case tickets(offset: String, limit: String)
    case shop(shopid: String)
    case ticket(id: String)
    case modifierGroups(offset: Int)
    case employees(offset: Int)
    case themes(offset: Int)
    case tables(offset: Int)
    case feedbackForms(offset: Int)
    case ads(offset: Int)
    case menus(shopid: String, embeddedMenus: [String])
    case childOfMenu(shopId: String, parentId: String, offset: Int)
    case menuFlatList(menuId: String)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .devices:
            return .post
        case .modifierGroups:
            return .get
        case .employees:
            return .get
        case .tables:
            return .get
        case .themes:
            return .get
        case .shop:
            return .get
        case .tickets:
            return .get
        case .ticket:
            return .get
        case .menus:
            return .get
        case .childOfMenu:
            return .get
        case .feedbackForms:
            return .get
        case .ads:
            return .get
        case .menuFlatList:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .devices:
            return "/devices"
        case .tables:
            return "/tables"
        case .employees:
            return "/employees"
        case .themes:
            return "/themes"
        case .modifierGroups:
            return "/modifiergroups"
        case .tickets:
            return "/tickets"
        case .ticket(let id):
            return "/tickets/\(id)"
        case .menus:
            return "/entities"
        case .childOfMenu:
            return "/entities"
        case .feedbackForms:
            return "/feedbackforms"
        case .ads:
            return "/ads"
        case .shop(let shopid):
            return "/shops/\(shopid)"
        case .menuFlatList(let menuId):
            return "/entities/\(menuId)/flat-list"
        }
    }

    // MARK: - Parameters
    private var parameters: String? {
        switch self {
        case .devices:
            return ""
        case .tables(let offset):
            return "?offset=\(offset)&limit=\(1000)"
        case .employees(let offset):
            return "?offset=\(offset)&limit=\(1000)"
        case .themes(let offset):
            return "?offset=\(offset)&limit=\(1000)"
        case .modifierGroups(let offset):
            return "?offset=\(offset)&limit=\(1000)"
        case .feedbackForms(let offset):
            return "?offset=\(offset)&limit=\(1000)"
        case .ticket:
            return "?populate=[\"items.entity\"]"
        case .ads:
            return "?where={\"published\":true}"
        case .menuFlatList:
            return ""
        case .tickets(let offset, let limit):
            return "?where={\"open\":true}&select=[\"name\",\"readableId\",\"_id\",\"guest_count\"]&offset=\(offset)&limit=\(limit)&sort=-updated_at"
        case .shop:
            return "?populate=[\"languages\",\"defaultLanguage\",\"currentTheme\"]"
        case .menus(let shopId, let embeddedMenus):
            if embeddedMenus.count > 0 {
                return "?where={\"$or\":[{\"type\":\"menu\",\"published\":true,\"shop\":\"\(shopId)\"},{\"_id\":{\"$in\":\(embeddedMenus)},\"published\":true}]}&fill=[\"descriptionWithoutTags\"]&limit=\(1000)"
            } else {
                return "?where={\"type\":\"menu\",\"published\":true,\"shop\":\"\(shopId)\"}&fill=[\"descriptionWithoutTags\"]&limit=\(1000)"
            }
        case .childOfMenu(let shopId, let parentId, let offset):
            return "?where={\"published\":true,\"shop\":\"\(shopId)\", \"path\":{\"$regex\":\"\(parentId)\", \"$options\":\"i\"}}&offset=\(offset)&limit=\(1000)&fill=[\"descriptionWithoutTags\"]"
        }
    }

    // MARK: - Body
    private var body: [String: Any]? {
        switch self {
        case .devices(let shopid, let pincode):
            var test = false
#if DEBUG
            test = true
#endif
            let dict = [ "udid": FDNetworkRouter.UDID,
                         "systemName": "iOS",
                         "systemVersion": UIDevice.current.systemVersion,
                         "model": "ipad",
                         "appVersion": FDNetworkRouter.appVersion,
                         "shop": shopid,
                         "test": test,
                         "pincode": pincode] as [String: Any]
            return dict
        case .modifierGroups:
            return nil
        case .employees:
            return nil
        case .tables:
            return nil
        case .themes:
            return nil
        case .shop:
            return nil
        case .tickets:
            return nil
        case .ticket:
            return nil
        case .menus:
            return nil
        case .childOfMenu:
            return nil
        case .feedbackForms:
            return nil
        case .ads:
            return nil
        case .menuFlatList:
            return nil
        }
    }

    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        var baseURL = ""
        switch FDNetworkRouter.URLType {
        case .product:
            baseURL = FinedineURL.productBaseURL.rawValue
        case .staging:
            baseURL = FinedineURL.stagingBaseURL.rawValue
        case .custom(let base, _):
            baseURL = base
        }
        var wholeUrl = baseURL + path

        // Parameters
        if let parameters = parameters {
            if !parameters.isEmpty {
                wholeUrl += parameters.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            }
        }
        let finalUrl = try wholeUrl.asURL()
        var urlRequest = URLRequest(url: finalUrl)

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.addValue("Bearer " + FDNetworkRouter.token, forHTTPHeaderField: "Authorization")

        // Body
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}

