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
    
    
    func login(block: (Dictionary<String, String> -> Void)) {
        let queryURL = NSURL(string: "https://cece9dca.ngrok.io/login/tc_999wx/67999164")
        let request = NSMutableURLRequest(URL: queryURL!)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let jsonData = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
            let jsonDict = jsonData as! Dictionary <String, String>
            block(jsonDict)
        }
        dataTask.resume()
    }
    
    
    func getEvents(block: (Array<AnyObject> -> Void)) {
        let queryURL = NSURL(string: "https://cece9dca.ngrok.io/events")
        let request = NSMutableURLRequest(URL: queryURL!)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let jsonData = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
            let jsonDict = jsonData as! Array <AnyObject>
            block(jsonDict)
        }
        dataTask.resume()
    }
    
    func getOutcomes(eventId: String, block: (Array<AnyObject> -> Void)) {
        let queryURL = NSURL(string: "https://cece9dca.ngrok.io/events/\(eventId)/outcomes")
        let request = NSMutableURLRequest(URL: queryURL!)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let jsonData = try!NSJSONSerialization.JSONObjectWithData(data!, options: [])
            let jsonDict = jsonData as! Array <AnyObject>
            block(jsonDict)
        }
        dataTask.resume()
    }
    
    func sendBet(outcomeId: String, ticket: String, priceF: String, stake: String) {
        
        let body = ["ticket": ticket, "priceFrac" : priceF, "stake": stake]
        
        let queryURL = NSURL(string: "https://cece9dca.ngrok.io/events/bets/\(outcomeId)")
        let request = NSMutableURLRequest(URL: queryURL!)
        request.HTTPMethod = "POST"
        request.HTTPBody = try!NSJSONSerialization.dataWithJSONObject(body, options: [])
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            print(error)
        }
        dataTask.resume()
        
    }
    
    
}
