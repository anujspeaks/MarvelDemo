//
//  MervelService.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 13/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import UIKit
import Foundation


typealias completionService = ((_ result : Bool?, _ response : Any? , _ error : Error?) -> Void)
var username = "" , password = ""



class MervelService: NSObject {
    
    private var networkStatus : NetworkStatus  {
        let reachability = NetReachability.reachabilityWithHostName(hostName: Constant.kMarvelServiceURL)
        return reachability
    }
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }

    func fetchMarvelData(sucess:@escaping(_ userData: [Results]) -> Void, failure: @escaping(_ failuremessage: String) -> Void){
        
        if networkStatus == .notReachable {
            failure(Constant.kNoNetwork)
            return
        }
        
        autoreleasepool { () -> Void in
            DispatchQueue.main.async{
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        let url = Constant.kMarvelServiceURL
        let strTimeStamp = NSDate().timeIntervalSince1970.description
        let partOne = "ts=\(strTimeStamp)&apikey=\(Constant.kPublickKey)&hash="
        let md5String = strTimeStamp+Constant.kPrivateKey+Constant.kPublickKey
        let strMD5 = md5String.myMD5String(md5String)
        let URLString = url+partOne+strMD5
        
        guard let endpoint = URL.init(string:URLString) else {
            print("Error creating endpoint")
            return failure("URL error")
        }
        let request = NSMutableURLRequest.init(url: endpoint)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                let code  = response?.getStatusCode()
                
                if (code == 200) {
//                    let backToString = String(data: data, encoding: String.Encoding.utf8)
//                    let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                    let str = String(data: data, encoding: String.Encoding.utf8)
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
                    let jsonDecoder = JSONDecoder()
                    let model = try jsonDecoder.decode(ModelCharacter.self, from: data)
                    print(model)
                    let arrModel = model.data1?.results
                    sucess(arrModel!)
                }
            } catch let error as JSONError {
                print(error.rawValue)
                failure(error.rawValue)
            } catch let error as NSError {
                print(error.localizedDescription)
                failure(error.localizedDescription)
            }
            }.resume()
        }
    }
    
    deinit {
        print("Done")
    }
    

}

