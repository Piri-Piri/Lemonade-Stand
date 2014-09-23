//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by David Pirih on 23.09.14.
//  Copyright (c) 2014 piri-piri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonsLabel: UILabel!
    @IBOutlet weak var icecubesLabel: UILabel!
    
    @IBOutlet weak var purchaseLemonsLabel: UILabel!
    @IBOutlet weak var purchaseIcecubesLabel: UILabel!
    
    @IBOutlet weak var lemonsForMixLabel: UILabel!
    @IBOutlet weak var icecubesForMixLabel: UILabel!
    
    var supplies = Supplies(initialMoney: 10, initialLemons: 1, initialIcecubes: 1)
    var price = Price()
    
    var purchasedLemons = 0
    var purchasedIceCubes = 0
    var lemonsForMix = 0
    var icecubesForMix = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func purchaseLemonsAction(sender: AnyObject) {
    }
    
    @IBAction func unpurchaseLemonsAction(sender: AnyObject) {
    }
    

    @IBAction func purchaseIcecubesAction(sender: AnyObject) {
    }
    
    
    @IBAction func unpurchaseIcecubesAction(sender: AnyObject) {
    }
    
    @IBAction func addLemonsForMixAction(sender: AnyObject) {
    }
    
    @IBAction func removeLemonsForMixAction(sender: AnyObject) {
    }
    
    
    @IBAction func addIcecubesForMixAction(sender: AnyObject) {
    }
    
    
    @IBAction func removeIcecubessForMixAction(sender: AnyObject) {
    }
    
    @IBAction func startDayAction(sender: AnyObject) {
    }
}

