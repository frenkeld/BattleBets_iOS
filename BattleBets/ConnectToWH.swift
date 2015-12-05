//
//  ConnectToWH.swift
//  BattleBets
//
//  Created by David Frenkel on 05/12/2015.
//  Copyright © 2015 BattleBets. All rights reserved.
//

import UIKit

class ConnectToWH: NSObject {
    
    let APIKey = "l7xx28e190817df14d42817958c51200009e"
    let APISecret = "8725cdf9f7af45f5ab42dd08dd63b4a0"
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession.sharedSession()
    
    
    

    func sendRequest() {
        let bodyObject = "username=tc_705pj&password=17705645"
        //let bodyObject = ["username":"tc_705pj", "password":"17705645"]
        
        let queryURL = NSURL(string: "10.11.21.175:8080")
        let request = NSMutableURLRequest(URL: queryURL!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json)", forHTTPHeaderField: "accept")
        request.setValue("\(APIKey))", forHTTPHeaderField: "who-apiKey")
        request.setValue("\(APISecret)", forHTTPHeaderField: "who-secret")
        
        //request.setValue("tc_705pj", forHTTPHeaderField: "username")
        //request.setValue("17705645", forHTTPHeaderField: "password")

        request.HTTPBody = bodyObject.dataUsingEncoding(NSUTF8StringEncoding)
        
        //print("Request Sent: \(request.HTTPBody?.description.utf8)")
        
        
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
           
            print(data)
            //var jsonData = try!NSJSONSerialization.dataWithJSONObject(data!, options: [])
        }
        dataTask.resume()
        
       
        
        //NSData(base64EncodedString: "username=tc_989uw&password=86989688", options:)


        
        
        
    }
    
}
