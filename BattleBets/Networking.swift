//
//  Networking.swift
//  BattleBets
//
//  Created by David Frenkel on 05/12/2015.
//  Copyright © 2015 BattleBets. All rights reserved.
//

import UIKit

class Networking: NSObject {
    
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession.sharedSession()
    
    var ticket = ""
    
    
    
    func login() {
        let queryURL = NSURL(string: "https://cece9dca.ngrok.io/login/tc_999wx/67999164")
        let request = NSMutableURLRequest(URL: queryURL!)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let jsonData = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
            let jsonDict = jsonData as! Dictionary <String, String>
            self.setVariables(jsonDict["ticket"]!)
        }
        dataTask.resume()
    }
    
    func setVariables(input: String) {
        ticket = input
        print(ticket)
    }
    
    func getEvents() {
        let queryURL = NSURL(string: "https://cece9dca.ngrok.io/events")
        let request = NSMutableURLRequest(URL: queryURL!)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let jsonData = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
            let jsonDict = jsonData as! Array <AnyObject>
        }
        dataTask.resume()
    }
    

    

}
