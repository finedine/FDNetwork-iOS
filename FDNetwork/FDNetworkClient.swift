//
//  FDNetworkClient.swift
//  FDNetwork
//
//  Created by Emre Ertan on 2.04.2020.
//  Copyright © 2020 Emre Ertan. All rights reserved.
//

import Foundation
import Alamofire

public class FDNetworkClient {

    static public func request(_ base: FinedineURLTypes = .baseURL, path: String, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
        let token = FDNetworkRouter.token
        let headers = ["Authorization": "Bearer \(token)"]
        var baseURL = ""
        switch base {
        case .baseURL:
            switch FDNetworkRouter.URLType {
            case .product:
                baseURL = FinedineURL.productBaseURL.rawValue
            case .staging:
                baseURL = FinedineURL.stagingBaseURL.rawValue
            case .custom(let base, _):
                baseURL = base
            }
        case .oldBaseURL:
            switch FDNetworkRouter.URLType {
            case .product:
                baseURL = FinedineURL.productOldBaseURL.rawValue
            case .staging:
                baseURL = FinedineURL.stagingOldBaseURL.rawValue
            case .custom(_, let oldBase):
                baseURL = oldBase
            }
        }

        return Alamofire.request("\(baseURL)\(path)", method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
    }

    //    MARK: - 1001
    static public func authenticateDevice(shopid: String, pincode: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.devices(shopid: shopid, pincode: pincode)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.authenticateDevice(shopid: shopid, pincode: pincode, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.authenticate.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.authenticateDevice(shopid: shopid, pincode: pincode, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.authenticate.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.authenticateDevice(shopid: shopid, pincode: pincode, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1002
    static public func getShop(shopid: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.shop(shopid: shopid)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getShop(shopid: shopid, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.shop.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getShop(shopid: shopid, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.shop.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getShop(shopid: shopid, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1003
    static public func getTables(offset: Int, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.tables(offset: offset)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getTables(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.tables.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getTables(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.tables.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getTables(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1004
    static public func getEmployees(offset: Int, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.employees(offset: offset)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getEmployees(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.employees.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getEmployees(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.employees.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getEmployees(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1005
    static public func getModifierGroups(offset: Int, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.modifierGroups(offset: offset)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getModifierGroups(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.modifierGroups.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getModifierGroups(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.modifierGroups.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getModifierGroups(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1007
    static public func getAds(offset: Int, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.ads(offset: offset)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getAds(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.ads.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getAds(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.ads.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getAds(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1008
    static public func getFeedbackForms(offset: Int, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.feedbackForms(offset: offset)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getFeedbackForms(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.feedbackForms.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getFeedbackForms(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.feedbackForms.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getFeedbackForms(offset: offset, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1009
    static public func getMenus(shopId: String, embeddedMenus: [String], numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.menus(shopid: shopId, embeddedMenus: embeddedMenus)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getMenus(shopId: shopId, embeddedMenus: embeddedMenus, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.entity.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                }  else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getMenus(shopId: shopId, embeddedMenus: embeddedMenus, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.entity.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getMenus(shopId: shopId, embeddedMenus: embeddedMenus, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    static public func getMenuChildren(shopId: String, menuId: String, offset: Int? = 0, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.childOfMenu(shopId: shopId, parentId: menuId, offset: offset!)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getMenuChildren(shopId: shopId, menuId: menuId, offset: offset!, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.entity.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getMenuChildren(shopId: shopId, menuId: menuId, offset: offset!, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let entityError = NSError(domain: FDErrorDomain.entity.rawValue, code: -1, userInfo: nil)
                            callback(nil, entityError)
                            return
                        }
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getMenuChildren(shopId: shopId, menuId: menuId, offset: offset!, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1012
    static public func getShopStatus(shopId: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(path: "/shops/\(shopId)/status", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getShopStatus(shopId: shopId, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.shopStatus.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getShopStatus(shopId: shopId, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.shopStatus.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getShopStatus(shopId: shopId, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1013
    static public func isDataUpToDate(deviceId: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: Bool?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(path: "/devices/\(deviceId)/version", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let status = json["status"] as? String {
                        if status != "out-of-date" {
                            callback(true, nil)
                            return
                        } else {
                            callback(false, nil)
                            return
                        }
                    } else {
                        if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                            if numberOfRetry ?? 1 > 1 {
                                FDNetworkClient.isDataUpToDate(deviceId: deviceId, numberOfRetry: numberOfRetry!-1, callback: callback)
                            } else {
                                let error = NSError(domain: FDErrorDomain.dataStatus.rawValue, code: code, userInfo: nil)
                                callback(nil, error)
                                return
                            }
                        } else {
                            if numberOfRetry ?? 1 > 1 {
                                FDNetworkClient.isDataUpToDate(deviceId: deviceId, numberOfRetry: numberOfRetry!-1, callback: callback)
                            } else {
                                let entityError = NSError(domain: FDErrorDomain.dataStatus.rawValue, code: -1, userInfo: nil)
                                callback(nil, entityError)
                                return
                            }
                        }
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.isDataUpToDate(deviceId: deviceId, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1014
    static public func createAndAdd(shopId: String, parameters: [String: Any], numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(.oldBaseURL, path: "shops/\(shopId)/ticket/createAndAdd", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.createAndAdd(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.createAndAdd.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else if let statusCode = response.response?.statusCode {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.createAndAdd(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.createAndAdd.rawValue, code: statusCode, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.createAndAdd(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.createAndAdd.rawValue, code: -1, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.createAndAdd(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1015
    static public func sendOrder(shopId: String, parameters: [String: Any], numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(.oldBaseURL, path: "shops/\(shopId)/ticket/add", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.sendOrder(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.sendOrder.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                }  else if let statusCode = response.response?.statusCode {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.sendOrder(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.sendOrder.rawValue, code: statusCode, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.sendOrder(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.sendOrder.rawValue, code: -1, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.sendOrder(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1016
    static public func sendKioskOrder(parameters: [String: Any], numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(.baseURL, path: "/tickets/kiosk", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.sendKioskOrder(parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.sendKioskOrder.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.sendKioskOrder(parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.sendKioskOrder.rawValue, code: -1, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.sendKioskOrder(parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1017
    static public func createTicket(shopId: String, parameters: [String: Any], numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(.oldBaseURL, path: "shops/\(shopId)/ticket/create", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.createTicket(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.createTicket.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else if let statusCode = response.response?.statusCode {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.createTicket(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.createTicket.rawValue, code: statusCode, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.createTicket(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.createTicket.rawValue, code: -1, userInfo: nil)
                        callback(nil, error)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.createTicket(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1018
    static public func requestService(shopId: String, parameters: [String: Any], numberOfRetry: Int? = 1, callback: @escaping (_ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(path: "/shops/\(shopId)/request-service", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary , let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.requestService(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let error = NSError(domain: FDErrorDomain.requestService.rawValue, code: code, userInfo: nil)
                        callback(error)
                        return
                    }
                } else {
                    callback(nil)
                    return
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.requestService(shopId: shopId, parameters: parameters, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback(response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1020
    static public func calculateCheckout(ticketId: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(path: "/tickets/\(ticketId)/calculate", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.calculateCheckout(ticketId: ticketId, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.calculateCheckout.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.calculateCheckout(ticketId: ticketId, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.calculateCheckout.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.calculateCheckout(ticketId: ticketId, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback(nil ,response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1021
    static public func getTickets(offset: String, limit: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.tickets(offset: offset, limit: limit)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getTickets(offset: offset, limit: limit, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.tickets.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getTickets(offset: offset, limit: limit, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.tickets.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getTickets(offset: offset, limit: limit, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1022
    static public func getTicket(id: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.ticket(id: id)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getTicket(id: id, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.ticket.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.getTicket(id: id, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.ticket.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getTicket(id: id, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1023
    static public func sendCheckout(ticketId: String, paymentMethod: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSDictionary?, _ error: NSError?) -> Void) -> Void {
        FDNetworkClient.request(path: "/tickets/\(ticketId)/request-checkout", method: .post, parameters: ["paymentMethod": paymentMethod]).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.sendCheckout(ticketId: ticketId, paymentMethod: paymentMethod, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.checkout.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if numberOfRetry ?? 1 > 1 {
                        FDNetworkClient.sendCheckout(ticketId: ticketId, paymentMethod: paymentMethod, numberOfRetry: numberOfRetry!-1, callback: callback)
                    } else {
                        let entityError = NSError(domain: FDErrorDomain.checkout.rawValue, code: -1, userInfo: nil)
                        callback(nil, entityError)
                        return
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.sendCheckout(ticketId: ticketId, paymentMethod: paymentMethod, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }

    //    MARK: - 1025
    static public func getMenuFlatList(menuId: String, numberOfRetry: Int? = 1, callback: @escaping (_ data: NSArray?, _ error: NSError?) -> Void) -> Void {
        Alamofire.request(FDNetworkRouter.menuFlatList(menuId: menuId)).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? NSArray {
                    if json.count == 0 {
                        callback([], nil)
                        return
                    } else {
                        callback(json, nil)
                        return
                    }
                } else {
                    if let json = response.result.value as? NSDictionary, let _ =  json["error"] as? String, let code =  json["statusCode"] as? Int {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getMenuFlatList(menuId: menuId, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let error = NSError(domain: FDErrorDomain.menuFlatList.rawValue, code: code, userInfo: nil)
                            callback(nil, error)
                            return
                        }
                    } else {
                        if numberOfRetry ?? 1 > 1 {
                            FDNetworkClient.getMenuFlatList(menuId: menuId, numberOfRetry: numberOfRetry!-1, callback: callback)
                        } else {
                            let entityError = NSError(domain: FDErrorDomain.menuFlatList.rawValue, code: -1, userInfo: nil)
                            callback(nil, entityError)
                            return
                        }
                    }
                }
            case .failure:
                if numberOfRetry ?? 1 > 1 {
                    FDNetworkClient.getMenuFlatList(menuId: menuId, numberOfRetry: numberOfRetry!-1, callback: callback)
                } else {
                    callback( nil, response.error as NSError?)
                    return
                }
            }
        }
    }
}

