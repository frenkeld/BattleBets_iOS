//
//  DetailViewViewController.swift
//  BattleBets
//
//  Created by David Frenkel on 05/12/2015.
//  Copyright © 2015 BattleBets. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {


    @IBOutlet weak var pastBetsList: UITextView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var moneySlider: UISlider!
    @IBOutlet weak var walletLabel: UILabel!
    var moneyLeft = 500
    var bet = 1
    
    var data = [String : AnyObject]()
    var outcomes = [AnyObject]()
    var ticket = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cashLabel.text = "£\(bet)"
        walletLabel.text = "£\(moneyLeft - bet)"
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let url = NSURL(string: "\(self.data["twitchUrl"]!)/embed")
            let request = NSURLRequest(URL: url!)
            self.webView.allowsInlineMediaPlayback = true
            self.webView.loadRequest(request)
        }
        
        let network = Networking()
        network.getOutcomes(data["id"] as! String) { (data) -> Void in
            self.outcomes = data
        }
        network.login { (data) -> Void in
            self.ticket = data["ticket"]!
            
            network.getPastBets(self.ticket) { (data) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    for item in data {
                        let da = item["stake"] as! String
                        print(da)
                        self.pastBetsList.text = self.pastBetsList.text + "Bet: £\(da)\n"
                        
                    }                })
            }
        }

        
        
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        bet = Int(sender.value)
        moneyLeft = 500 - bet
        cashLabel.text = "£\(bet)"
        walletLabel.text = "£\(moneyLeft)"
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func betTeamOne(sender: AnyObject) {
        let tone = outcomes[0]
        
        let smth = tone["odds"] as! Dictionary <String, AnyObject>
        
        let deep = smth["livePrice"] as! Dictionary <String, AnyObject>
        
        let priceFrac = deep["priceFrac"] as! String
        
        let id = tone["id"] as! String
        
        let network = Networking()
        
        network.sendBet(id, ticket: ticket, priceF: priceFrac, stake: "\(moneySlider.value)") { (data) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.moneyLeft = self.moneyLeft - Int(self.moneySlider.value)
                self.presentViewController(data, animated: true, completion: nil)

            })
        }
        
    }
    
    @IBAction func betTeamTwo(sender: AnyObject) {
        let tone = outcomes[1]
        
        let smth = tone["odds"] as! Dictionary <String, AnyObject>
        
        let deep = smth["livePrice"] as! Dictionary <String, AnyObject>
        
        let priceFrac = deep["priceFrac"] as! String
        
        let id = tone["id"] as! String
        
        let network = Networking()
        
        network.sendBet(id, ticket: ticket, priceF: priceFrac, stake: "\(moneySlider.value)") { (data) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.moneyLeft = self.moneyLeft - Int(self.moneySlider.value)
                self.presentViewController(data, animated: true, completion: nil)
                
            })
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
