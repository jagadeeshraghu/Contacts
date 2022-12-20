//
//  NetworkManager.swift
//  Paypal
//
//  Created by Jagadeesh Raghu on 11/4/22.
//

import Foundation


final class NetworkManager {
    
    
    static func downloadData(api:String,params:[AnyHashable:Any],callback:@escaping(_ data:Data?,_ response:HTTPURLResponse?,_ error:Error?)->Void){
        
        
        var urlRequest = URLRequest.init(url: URL.init(string: api)!)
        let httpMethod = params[ParamType.HttpMethod] as? HttpMethod
        urlRequest.httpMethod  = httpMethod?.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, resonse, error) in
            
            let httpResponse = resonse as? HTTPURLResponse
            
            if httpResponse?.statusCode == 200{
                callback(data,httpResponse,error)
            }
            
            
        }
        DispatchQueue.global(qos: .background).async {
            dataTask.resume()

        }
                        
    }
    
    
    
    
}
