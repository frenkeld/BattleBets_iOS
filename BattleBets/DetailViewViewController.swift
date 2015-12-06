//
//  DetailViewViewController.swift
//  BattleBets
//
//  Created by David Frenkel on 05/12/2015.
//  Copyright © 2015 BattleBets. All rights reserved.
//

import UIKit

class DetailViewViewController: UIViewController {


    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var moneySlider: UISlider!
    @IBOutlet weak var walletLabel: UILabel!
    var moneyLeft = 500
    var bet = 1
    
    var data = [String : AnyObject]()
    //var outcomes =
    
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
            print(data.allkeys)
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
        
    }
    
    @IBAction func betTeamTwo(sender: AnyObject) {
        
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
